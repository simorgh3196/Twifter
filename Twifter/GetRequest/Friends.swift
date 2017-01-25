//
//  Friends.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET friends/ids

 Returns a cursored collection of user IDs for every user the specified user is following (otherwise known as their “friends”).
 [Read more ...](https://dev.twitter.com/rest/reference/get/friends/ids)

 - Remark: 15 / 15 min
 */
public struct GetFriendsIds {
    let userId: String?
    let screenName: String?
    let cursor: Int? // semi-optional
    let stringifyIds: Bool?
    let count: Int?
}


/**
 GET friends/list

 Returns a cursored collection of user objects for every user the specified user is following (otherwise known as their “friends”).
 [Read more ...](https://dev.twitter.com/rest/reference/get/friends/list)

 - Remark: (user) 15 / 15 min | (app) 30 / 15 min
 */
public struct GetFriendsList {
    let userId: String?
    let screenName: String?
    let cursor: Int? // semi-optional
    let count: Int?
    let skipStatus: Bool?
    let includeUserEntities: Bool?
}
