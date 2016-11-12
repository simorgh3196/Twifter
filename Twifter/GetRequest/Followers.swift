//
//  Followers.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET followers/ids

 Returns a cursored collection of user IDs for every user following the specified user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/favorites/ids)
 
 - Remark: Rate limit: 15 / 15 min
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
 
 - Remark: Rate limit: (user auth) 15 / 15 min | (app auth) 30 / 15 min
 */
public struct GetFollowersList {
    let userId: String?
    let screenName: String?
    let cursor: Int?
    let count: Int?
    let skipStatus: Bool?
    let includeUserEntities: Bool?
}
