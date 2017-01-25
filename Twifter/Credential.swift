//
//  Credential.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/30.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import Accounts

public class Credential {

    public struct ConsumerToken {
        public var token: String
        public var secret: String
    }

    public struct AccessToken {
        public var token: String
        public var secret: String

        public var screenName: String?
        public var userID: String?

        public init?(queries: [String: Any]) {
            guard
                let token = queries["oauth_token"] as? String,
                let secret = queries["oauth_token_secret"] as? String
                else { return nil }

            self.token = token
            self.secret = secret
            self.screenName = queries["screen_name"] as? String
            self.userID = queries["user_id"] as? String
        }
    }

    internal(set) static var consumerToken: ConsumerToken!

    internal(set) var accessToken: AccessToken?
    internal(set) var account: ACAccount?


    init() {
    }

    public init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }

    public init(acAccount account: ACAccount) {
        self.account = account
    }


    /**
     Register consumer key and consumer secret. Have to call at once before use twitter api.

     - parameter key:    Twitter consumer key.
     - parameter secret: Twitter consumer secret.
     */
    public static func registerConsumerToken(token: String, secret: String) {
        self.consumerToken = ConsumerToken(token: token, secret: secret)
    }

}
