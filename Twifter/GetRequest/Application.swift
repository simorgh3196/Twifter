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
public struct GetApplicationRateLimitStatus {
    let resources: Resources?

    public enum Resources: String {
        case statuses, friends, trends, help
    }

    /**
     GET application/rate_limit_status

     - parameter resources:
            A comma-separated list of resource families you want to know the current rate limit disposition for.
            For best performance, only specify the resource families pertinent to your application.
            See API Rate Limiting for more information.

     - returns: Request
     */
    init(resources: Resources? = nil) {
        self.resources = resources
    }
}
