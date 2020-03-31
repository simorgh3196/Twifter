//
//  Endpoints.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

extension TwitterEndpoint {

    public static func postOAuthRequestToken(oauthCallbackURL: URL) -> TwitterOAuthEndpoint<OAuthRequestToken> {
        return .init(
            baseURL: .oauth,
            path: "/oauth/request_token",
            method: .post,
            bodyParameters: [
                "oauth_callback": oauthCallbackURL.absoluteString
            ]
        )
    }

    public static func postOAuthAccessToken(oauthVerifier: String) -> TwitterOAuthEndpoint<AccessToken> {
        return .init(
            baseURL: .oauth,
            path: "/oauth/access_token",
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
