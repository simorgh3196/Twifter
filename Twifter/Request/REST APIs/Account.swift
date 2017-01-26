//
//  Account.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit

// MARK: - GET Request

/**
 GET account/settings

 Returns settings (including current trend, geo and sleep time information) for the authenticating user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/account/settings)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetAccountSettings: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/account/settings.json"

    public let credential: Credential
}


/**
 GET account/verify_credentials

 Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; returns a 401 status code and an error message if not. Use this method to test if supplied user credentials are valid.
 [Read more ...](https://dev.twitter.com/rest/reference/get/account/verify_credentials)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetAccountVerifyCredentials: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/account/verify_credentials.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "include_entities": includeEntities,
            "skip_status": skipStatus,
            "include_email": includeEmail
        ])
    }

    public let credential: Credential
    public let includeEntities: Bool?
    public let skipStatus: Bool?
    public let includeEmail: Bool?
}
