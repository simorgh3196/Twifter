//
//  OAuthRequest.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/27.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import APIKit


public protocol OAuthRequest: TwifterRequest {
}

extension OAuthRequest {

    public var baseURL: URL {
        return URL(string: "https://api.twitter.com")!
    }

    public var dataParser: DataParser {
        return FormURLEncodedDataParser(encoding: .utf8)
    }

}


/**
 send FetchOAuthRequestToken
   -> oauth_token(request_token), oauth_token_secret

 openURL https://api.twitter.com/oauth/authenticate?oauth_token=[oauth_token(request_token)]
   -> oauth_token, oauth_verifier

 send FetchOAuthAccessToken with [oauth_verifier]
   -> oauth_token, oauth_token_secret
 */


public struct FetchOAuthRequestToken: OAuthRequest {
    public let method: HTTPMethod = .post
    public let path = "/oauth/request_token"
    public typealias Response = (token: Credential.AccessToken, url: URL)

    public var additionalHeaderFields: [String : String] {
        guard let url = callbackURL else { return [:] }
        return ["oauth_callback": url.absoluteString]
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let tokenDic = object as? [String: Any] else {
            throw TwifterError.invalidResponseData
        }
        guard let requestToken = Credential.AccessToken(queries: tokenDic) else {
            throw TwifterError.parseFailed
        }
        let url = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken.token)")!
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

    public var queryParameters: [String : Any]? {
        return ["oauth_verifier": verifier]
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
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
