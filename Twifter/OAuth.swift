//
//  OAuth.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/27.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit

public struct FetchOAuthRequestToken: OAuthRequest {
    public let method: HTTPMethod = .post
    public let path = "/oauth/request_token"
    public typealias Response = (token: Credential.AccessToken, url: URL)

    public var additionalHeaderFields: [String : String] {
        guard let url = callbackURL else { return [:] }
        return ["oauth_callback": url.absoluteString]
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let queries = object as? [String: String] else {
            throw TwifterError.invalidResponseData
        }

        guard let requestToken = Credential.AccessToken(queries: queries) else {
            throw TwifterError.parseFailed
        }
        let url = URL(string: "/oauth/authenticate?oauth_token=\(requestToken.token)", relativeTo: baseURL)!

        return (requestToken, url)
    }

    public let credential: Credential
    public let callbackURL: URL?
}

public struct FetchOAuthAccessToken: OAuthRequest {
    public let method: HTTPMethod = .post
    public let path = "/oauth/access_token"
    public typealias Response = Credential.AccessToken

    public var additionalHeaderFields: [String: String]? {
        return ["oauth_verifier": verifier]
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Credential.AccessToken {
        guard let tokenDic = object as? [String: Any] else {
            throw TwifterError.invalidResponseData
        }
        guard let token = Credential.AccessToken(queries: tokenDic) else {
            throw TwifterError.parseFailed
        }
        return token
    }

    public let credential: Credential
    public let verifier: String
}
