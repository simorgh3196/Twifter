//
//  Endpoints.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

extension TwitterEndpoint {
    public static func postOAuthRequestToken(oauthCallbackURL: URL) -> TwitterEndpoint<AccessToken> {
        .init(
            baseURL: .oauth1,
            path: "/request_token",
            method: .post,
            bodyParameters: [
                "oauth_callback": oauthCallbackURL.absoluteString
            ]
        )
    }

    public static func postOAuthAccessToken(oauthVerifier: String) -> TwitterEndpoint<AccessToken> {
        .init(
            baseURL: .oauth1,
            path: "/access_token",
            method: .post,
            headerFields: [
                "Content-Type": "application/x-www-form-urlencoded"
            ],
            bodyParameters: [
                "oauth_verifier": oauthVerifier
            ]
        )
    }
}
