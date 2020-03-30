//
//  Twifter.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/25.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import UIKit

open class Twifter {

    public let api: API
    public let loginManager: LoginManager

    public var credential: Credential { api.oauthSigner.credential }
    public var accessToken: AccessToken? { api.oauthSigner.accessToken }

    public convenience init(consumerKey: String,
                            consumerSecret: String,
                            accessToken: AccessToken? = nil,
                            session: URLSession = .shared) {
        let credential = Credential(consumerKey: consumerKey, consumerSecret: consumerSecret)
        let oauthSigner = OAuthSigner(credential: credential, accessToken: accessToken)
        let api = API(session: session, oauthSigner: oauthSigner)
        let callbackURL = URL(string: "twitterkit-\(credential.consumerKey)://")!
        let loginManager = LoginManager(api: api, callbackURL: callbackURL)
        self.init(api: api, loginManager: loginManager)
    }

    public init(api: API, loginManager: LoginManager) {
        self.api = api
        self.loginManager = loginManager
    }

    open func handleOpen(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return loginManager.handleOpen(url, options: options)
    }

    open func login(method: LoginMethod, completionHandler: @escaping (Result<AccessToken, TwifterError>) -> Void) {
        switch method {
        case .twitterApp:
            loginManager.loginWithTwitterApp(completionHandler: completionHandler)
        case .authenticationSession:
            loginManager.loginWithAuthenticationSession(completionHandler: completionHandler)
        }
    }
}
