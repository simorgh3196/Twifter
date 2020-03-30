//
//  OAuthRequestToken.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public struct OAuthRequestToken: Decodable, Equatable, Hashable {
    let oauthToken: String
    let oauthTokenSecret: String
    let oauthCallbackConfirmed: String
}
