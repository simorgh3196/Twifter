//
//  Lists.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET lists/list

 Returns all lists the authenticating or specified user subscribes to, including their own. The user is specified using the user_id or screen_name parameters. If no user is given, the authenticating user is used.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/list)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsList {
    let userId: String?
    let screenName: String?
    let reverse: Bool?
}


/**
 GET lists/members

 Returns the members of the specified list. Private list members will only be shown if the authenticated user owns the specified list.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/members)

 __Rate limit__: (user) 180 / 15 min | (app) 15 / 15 min
 */
public struct GetListsMembers {
    let listId: Int
    let slug: String
    let ownerScreenName: String?
    let ownerId: String?
    let count: Int?
    let cursor: Int?
    let includeEntities: Bool?
    let skipStatus: Bool?
}


/**
 GET lists/members/show

 Check if the specified user is a member of the specified list.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/members/show)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsMembersShow {
    let listId: Int
    let slug: String
    let userId: String?
    let screenName: String?
    let ownerScreenName: String?
    let ownerId: String?
    let includeEntities: Bool?
    let skipStatus: Bool?
}


/**
 GET lists/memberships

 Returns the lists the specified user has been added to. If user_id or screen_name are not provided the memberships for the authenticating user are returned.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/memberships)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsMemberships {
    let userId: String?
    let screenName: String?
    let count: Int?
    let cursor: Int?
    let filterToOwnedLists: Bool?
}


/**
 GET lists/ownerships

 Returns the lists owned by the specified Twitter user. Private lists will only be shown if the authenticated user is also the owner of the lists.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/ownerships)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsOwnerships {
    let userId: String?
    let screenName: String?
    let count: Int?
    let cursor: Int?
}


/**
 GET lists/show

 Returns the specified list. Private lists will only be shown if the authenticated user owns the specified list.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/show)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsShow {
    let listId: Int
    let slug: String
    let ownerScreenName: String?
    let ownerId: String?
}


/**
 GET lists/statuses

 Returns a timeline of tweets authored by members of the specified list. Retweets are included by default. Use the include_rts=false parameter to omit retweets.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/statuses)

 __Rate limit__: 180 / 15 min
 */
public struct GetListsStatuses {
    let listId: Int
    let slug: String
    let ownerScreenName: String?
    let ownerId: String?
    let sinceId: String?
    let maxId: String?
    let count: Int?
    let includeEntities: Bool?
    let includeRts: Bool?
}


/**
 GET lists/subscribers

 Returns the subscribers of the specified list. Private list subscribers will only be shown if the authenticated user owns the specified list.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/subscribers)

 __Rate limit__: (user) 180 / 15 min | (app) 15 / 15 min
 */
public struct GetListsSubscribers {
    let listId: Int
    let slug: String
    let ownerScreenName: String?
    let ownerId: String?
    let count: Int?
    let cursor: Int?
    let includeEntities: Bool?
    let skipStatus: Bool?
}


/**
 GET lists/subscribers/show

 Check if the specified user is a subscriber of the specified list. Returns the user if they are subscriber.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/subscribers/show)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsSubscribersShow {
    let ownerScreenName: String?
    let ownerId: String?
    let listId: Int
    let slug: String
    let userId: String
    let screenName: String
    let includeEntities: Bool?
    let skipStatus: Bool?
}


/**
 GET lists/subscriptions

 Obtain a collection of the lists the specified user is subscribed to, 20 lists per page by default. Does not include the user’s own lists.
 [Read more ...](https://dev.twitter.com/rest/reference/get/lists/subscriptions)

 __Rate limit__: 15 / 15 min
 */
public struct GetListsSubscriptions {
    let userId: String?
    let screenName: String?
    let count: Int?
    let cursor: Int?
}
