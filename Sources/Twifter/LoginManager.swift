//
//  LoginManager.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/30.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import AuthenticationServices
import UIKit
import SafariServices

@MainActor
public class LoginManager: NSObject {

    public let api: API
    public let callbackURL: URL

    public var credential: Credential { api.oauthSigner.credential }

    public private(set) var accessToken: AccessToken? {
        get { api.oauthSigner.accessToken }
        set { api.oauthSigner.updateAccessToken(newValue) }
    }

    var application: UIApplication = .shared
    var notificationCenter: NotificationCenter = .default

    private var cancelObserver: NSObjectProtocol?
    private var openURLHandler: ((URL, [UIApplication.OpenURLOptionsKey: Any]) -> Void)?
    private var authenticationSession: ASWebAuthenticationSession?

    public init(api: API, callbackURL: URL) {
        self.api = api
        self.callbackURL = callbackURL
    }

    open func handleOpen(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        guard url.scheme == callbackURL.scheme, let openURLHandler else { return false }
        openURLHandler(url, options)
        return true
    }

    open func loginWithAuthenticationSession() async throws -> AccessToken {
        let requestToken = try await api.call(.postOAuthRequestToken(oauthCallbackURL: callbackURL))
        try Task.checkCancellation()

        api.oauthSigner.updateAccessToken(requestToken)

        let verifierURL = try await openAuthenticationSession(oauthToken: requestToken.oauthToken)
        try Task.checkCancellation()

        guard let verifier = parseCallbackURL(verifierURL) else {
            throw TwifterError.loginError(reason: .invalidCallbackURL)
        }

        let verifiedToken = try await api.call(.postOAuthAccessToken(oauthVerifier: verifier))
        api.oauthSigner.updateAccessToken(verifiedToken)

        return verifiedToken
    }

    open func openAuthenticationSession(oauthToken: String) async throws -> URL {
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { @MainActor continuation in
                let authURL = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(oauthToken)")!

                self.authenticationSession = ASWebAuthenticationSession(
                    url: authURL,
                    callbackURLScheme: callbackURL.scheme,
                    completionHandler: { url, error in
                        if let error {
                            continuation.resume(throwing: TwifterError.loginError(reason: .catchError(error)))
                            return
                        }

                        guard let url else {
                            continuation.resume(throwing: TwifterError.loginError(reason: .cannotGetCallbackURL))
                            return
                        }

                        continuation.resume(returning: url)
                    }
                )

                self.authenticationSession!.presentationContextProvider = self
                self.authenticationSession!.start()
            }
        } onCancel: { [authenticationSession] in
            authenticationSession?.cancel()
        }
    }

    private func parseCallbackURL(_ url: URL) -> String? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let queryItems = components?.queryItems,
              let oauthVerifier = queryItems.first(where: { $0.name == "oauth_verifier" }).flatMap(\.value)
        else { return nil }

        return oauthVerifier
    }
}

@available(iOS 13.0, *)
extension LoginManager: ASWebAuthenticationPresentationContextProviding {

    open func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        application.windows.first(where: \.isKeyWindow)!
    }
}
