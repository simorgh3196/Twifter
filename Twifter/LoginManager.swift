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

public enum LoginMethod {
    case twitterApp
    case authenticationSession
}

open class LoginManager: NSObject {

    public let api: API
    public let callbackURL: URL

    public var credential: Credential { api.oauthSigner.credential }

    public private(set) var accessToken: AccessToken? {
        get { api.oauthSigner.accessToken }
        set { api.oauthSigner.accessToken = newValue }
    }

    var application: UIApplication = .shared
    var notificationCenter: NotificationCenter = .default

    private var cancelObserver: NSObjectProtocol?
    private var openURLHandler: ((URL, [UIApplication.OpenURLOptionsKey: Any]) -> Void)?
    private var authenticationSession: Any?

    public init(api: API, callbackURL: URL) {
        self.api = api
        self.callbackURL = callbackURL
    }

    open func handleOpen(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        guard url.scheme == callbackURL.scheme, let openURLHandler = openURLHandler else { return false }
        openURLHandler(url, options)
        return true
    }

    open func loginWithTwitterApp(completionHandler: @escaping ((Result<AccessToken, TwifterError>) -> Void)) {
        let twitterAppURLScheme = URL(string:
            "twitterauth://authorize"
                + "?consumer_key=\(credential.consumerKey)"
                + "&consumer_secret=\(credential.consumerSecret)"
                + "&oauth_callback=twitterkit-\(credential.consumerKey)"
            )!

        guard application.canOpenURL(twitterAppURLScheme) else {
            completionHandler(.failure(.loginError(reason: .doNotHaveTwitterApp)))
            return
        }

        application.open(twitterAppURLScheme) { [weak self] _ in
            self?.openURLHandler = { url, options in
                defer { self?.openURLHandler = nil }
                self?.cancelObserver = nil

                guard let accessToken = self?.parseCallbackURLFromTwitterApp(url) else {
                    completionHandler(.failure(.loginError(reason: .invalidCallbackURL)))
                    return
                }

                self?.accessToken =  accessToken
                completionHandler(.success(accessToken))
            }

            self?.cancelObserver = self?.notificationCenter.addObserver(
                forName: UIApplication.willEnterForegroundNotification,
                object: nil,
                queue: .main,
                using: { _ in
                    if self?.openURLHandler != nil {
                        self?.openURLHandler = nil
                        completionHandler(.failure(.loginError(reason: .cancelled)))
                    }
                    self?.cancelObserver = nil
                }
            )
        }
    }

    open func loginWithAuthenticationSession(
        completionHandler: @escaping ((Result<AccessToken, TwifterError>) -> Void)
    ) {
        api.call(.postOAuthRequestToken(oauthCallbackURL: callbackURL)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let oauthToken):
                let requestToken = AccessToken(oauthToken: oauthToken.oauthToken,
                                               oauthTokenSecret: oauthToken.oauthTokenSecret)
                self.api.oauthSigner.accessToken = requestToken
                self.openAuthenticationSession(oauthToken: requestToken.oauthToken) { [weak self] url, error in
                    if let error = error {
                        completionHandler(.failure(.loginError(reason: .catchError(error))))
                        return
                    }

                    guard let url = url else {
                        completionHandler(.failure(.loginError(reason: .cannotGetCallbackURL)))
                        return
                    }

                    guard let verifier = self?.parseCallbackURL(url) else {
                        completionHandler(.failure(.loginError(reason: .invalidCallbackURL)))
                        return
                    }

                    self?.api.call(.postOAuthAccessToken(oauthVerifier: verifier)) { [weak self] result in
                        switch result {
                        case .success(let accessToken):
                            self?.accessToken = accessToken
                            completionHandler(.success(accessToken))
                        case .failure(let error):
                            completionHandler(.failure(.loginError(reason: .catchError(error))))
                        }
                    }
                }
            case .failure(let error):
                completionHandler(.failure(.loginError(reason: .catchError(error))))
            }
        }
    }

    open func openAuthenticationSession(oauthToken: String, completionHandler: @escaping ((URL?, Error?) -> Void)) {
        let authURL = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(oauthToken)")!

        if #available(iOS 12.0, *) {
            let authenticationSession = ASWebAuthenticationSession(url: authURL,
                                                                   callbackURLScheme: self.callbackURL.scheme,
                                                                   completionHandler: completionHandler)
            if #available(iOS 13.0, *) {
                authenticationSession.presentationContextProvider = self
            }
            authenticationSession.start()
            self.authenticationSession = authenticationSession
        } else { // if iOS 11.x
            let authenticationSession = SFAuthenticationSession(url: authURL,
                                                                callbackURLScheme: self.callbackURL.scheme,
                                                                completionHandler: completionHandler)
            authenticationSession.start()
            self.authenticationSession = authenticationSession
        }
    }

    public func parseCallbackURLFromTwitterApp(_ url: URL) -> AccessToken? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let queryItems = components?.queryItems,
            let oauthToken = queryItems.first(where: { $0.name == "oauth_token" }).flatMap({ $0.value }),
            let oauthTokenSecret = queryItems.first(where: { $0.name == "oauth_token_secret" }).flatMap({ $0.value })
            else { return nil }

        return AccessToken(oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret)
    }

    public func parseCallbackURL(_ url: URL) -> String? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let queryItems = components?.queryItems,
            let oauthVerifier = queryItems.first(where: { $0.name == "oauth_verifier" }).flatMap({ $0.value })
            else { return nil }

        return oauthVerifier
    }
}

@available(iOS 13.0, *)
extension LoginManager: ASWebAuthenticationPresentationContextProviding {

    open func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return application.keyWindow!
    }
}
