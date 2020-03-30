//
//  OAuthRequestToken.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public struct OAuthRequestToken: Decodable, Equatable, Hashable {
    public let oauthToken: String
    public let oauthTokenSecret: String
    public let oauthCallbackConfirmed: Bool

    public init(oauthToken: String, oauthTokenSecret: String, oauthCallbackConfirmed: Bool) {
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.oauthCallbackConfirmed = oauthCallbackConfirmed
    }
}
