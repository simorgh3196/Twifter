//
//  Mutes.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET mutes/users/ids

 Returns an array of numeric user ids the authenticating user has muted.
 [Read more ...](https://dev.twitter.com/rest/reference/get/mutes/users/ids)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetMutesUsersIds {
    let cursor: Int?
}


/**
 GET mutes/users/list

 Returns an array of user objects the authenticating user has muted.
 [Read more ...](https://dev.twitter.com/rest/reference/get/mutes/users/list)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetMutesUsersList {
    let cursor: Int?
    let includeEntities: Bool?
    let skipStatus: Bool?
}
