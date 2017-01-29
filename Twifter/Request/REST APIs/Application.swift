//
//  Application.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET application/rate_limit_status

 Returns the current rate limits for methods belonging to the specified resource families.
 [Read more ...](https://dev.twitter.com/rest/reference/get/application/rate_limit_status)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetApplicationRateLimitStatus: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/application/rate_limit_status.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "resources": resources?.rawValue
            ])
    }

    public enum Resources: String {
        case statuses, friends, trends, help
    }

    public let credential: Credential
    public let resources: Resources?
}
