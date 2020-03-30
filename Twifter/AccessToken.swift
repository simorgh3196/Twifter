//
//  AccessToken.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public struct AccessToken: Decodable, Equatable, Hashable {
    public let oauthToken: String
    public let oauthTokenSecret: String

    public init(oauthToken: String, oauthTokenSecret: String) {
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
    }
}
