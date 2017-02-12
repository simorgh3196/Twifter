//
//  Followers.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET followers/ids

 Returns a cursored collection of user IDs for every user following the specified user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/favorites/ids)

 __Rate limit__: 15 / 15 min
 */
public struct GetFollowersIds {
    let userId: String?
    let screenName: String?
    let cursor: Int? // semi-optional
    let stringifyIds: Bool?
    let count: Int?
}


/**
 GET followers/list

 Returns a cursored collection of user objects for users following the specified user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/followers/list)

 __Rate limit__: (user auth) 15 / 15 min | (app auth) 30 / 15 min
 */
public struct GetFollowersList {
    let userId: String?
    let screenName: String?
    let cursor: Int?
    let count: Int?
    let skipStatus: Bool?
    let includeUserEntities: Bool?
}
