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

    private enum CodingKeys: CodingKey {
        case oauthToken
        case oauthTokenSecret
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let valueStrings = try container.decode(String.self)

        let values = [String: String](uniqueKeysWithValues: valueStrings
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .map { (key: $0[0], value: $0[1]) }
        )

        guard let oauthToken = values["oauth_token"],
              let oauthTokenSecret = values["oauth_token_secret"] else {
            throw TwifterError.loginError(reason: .invalidAccessToken)
        }

        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
    }
}
