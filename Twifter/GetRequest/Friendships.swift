//
//  Friendships.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET friendships/incoming

 Returns a collection of numeric IDs for every user who has a pending request to follow the authenticating user.
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetFriendshipsIncoming {
    let cursor: Int?  // semi-optional
    let stringifyIds: Bool?
}


/**
 GET friendships/lookup

 Returns the relationships of the authenticating user to the comma-separated list of up to 100 screen_names or user_ids provided. Values for connections can be: following, following_requested, followed_by, none, blocking, muting.

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetFriendshipsLookup {
    let screenName: [String]?
    let userId: [String]?
}


/**
 GET friendships/no_retweets/ids

 Returns a collection of user_ids that the currently authenticated user does not want to receive retweets from.
 [Read more ...](https://dev.twitter.com/rest/reference/get/friendships/incoming)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetFriendshipsNoRetweetIds {
    let stringifyIds: Bool?
}


/**
 GET friendships/outgoing

 Returns a collection of numeric IDs for every protected user for whom the authenticating user has a pending follow request.
 [Read more ...](https://dev.twitter.com/rest/reference/get/friendships/outgoing)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetFriendsOutgoing {
    let cursor: Int?  // semi-optional
    let stringifyIds: Bool?
}


/**
 GET friendships/show

 Returns detailed information about the relationship between two arbitrary users.
 [Read more ...](https://dev.twitter.com/rest/reference/get/friendships/show)
 
 - Remark: Rate limit: (user) 180 / 15 min | (app) 15 / 15 min
 */
public struct GetFriendsShow {
    let sourceId: String?
    let sourceScreenName: String?
    let targetId: String?
    let targetScreenName: String?
}
