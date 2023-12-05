//
//  Twifter.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/25.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import UIKit

@available(*, deprecated, renamed: "TwitterClient", message: "Use TwitterClient instead")
public typealias Twifter = TwitterClient

public class TwitterClient {
    public let api: API
    public let callbackURL: URL
    public var loginManager: LoginManager?

    public var credential: Credential { api.oauthSigner.credential }
    public var accessToken: AccessToken? { api.oauthSigner.accessToken }

    public convenience init(consumerKey: String,
                            consumerSecret: String,
                            accessToken: AccessToken? = nil,
                            session: URLSession = .shared) {
        let credential = Credential(consumerKey: consumerKey, consumerSecret: consumerSecret)
        let oauthSigner = OAuth1Signer(credential: credential, accessToken: accessToken)
        let api = API(oauthSigner: oauthSigner, session: session)
        let callbackURL = URL(string: "twitterkit-\(credential.consumerKey)://")!
        self.init(api: api, callbackURL: callbackURL)
    }

    init(api: API, callbackURL: URL) {
        self.api = api
        self.callbackURL = callbackURL
    }

    // MARK: - Login

    @MainActor
    public func handleOpen(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        if loginManager == nil {
            loginManager = LoginManager(api: api, callbackURL: callbackURL)
        }
        return loginManager!.handleOpen(url, options: options)
    }

    @MainActor
    public func login() async throws -> AccessToken {
        if loginManager == nil {
            loginManager = LoginManager(api: api, callbackURL: callbackURL)
        }
        return try await loginManager!.loginWithAuthenticationSession()
    }

    // MARK: - Tweets

    public func createTweet() async throws {
    }
}
