//
//  Statuses.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET statuses/home_timeline

 Returns a collection of the most recent Tweets and retweets posted by the authenticating user and the users they follow. The home timeline is central to how most users interact with the Twitter service.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/home_timeline)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetStatusesHomeTimeline {
    let count: Int?
    let sinceId: String?
    let maxId: String?
    let trimUser: Bool?
    let excludeReplies: Bool?
    let contributorDetails: Bool?
    let includeEntities: Bool?
}


/**
 GET statuses/lookup

 Returns fully-hydrated tweet objects for up to 100 tweets per request, as specified by comma-separated values passed to the id parameter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/lookup)

 - Remark: Rate limit: (user) 180 / 15 min | (app) 60 / 15 min
 */
public struct GetStatusesLookup {
    let id: String
    let includeEntities: Bool?
    let trimUser: Bool?
    let map: Bool?
}


/**
 GET statuses/mentions_timeline

 Returns the 20 most recent mentions (tweets containing a users’s @screen_name) for the authenticating user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetStatusesMentionsTimeline {
    let count: Int?
    let sinceId: String?
    let maxId: String?
    let trimUser: Bool?
    let contributorDetails: Bool?
    let includeEntities: Bool?
}


/**
 GET statuses/retweeters/ids

 Returns a collection of up to 100 user IDs belonging to users who have retweeted the tweet specified by the id parameter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids)

 - Remark: Rate limit: (user) 15 / 15 min | (app) 60 / 15 min
 */
public struct GetStatusesRetweetersIds {
    let id: String
    let cursor: Int? // semi-optional
    let stringifyIds: Bool?
}


/**
 GET statuses/retweets/:id

 Returns a collection of the 100 most recent retweets of the tweet specified by the id parameter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/retweets/id)

 - Remark: Rate limit: (user) 15 / 15 min | (app) 60 / 15 min
 */
public struct GetStatusesRetweets {
    let id: String
    let count: Int?
    let trimUser: Bool?
}


/**
 GET statuses/retweets_of_me

 Returns the most recent tweets authored by the authenticating user that have been retweeted by others. This timeline is a subset of the user’s GET statuses / user_timeline.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetStatusesRetweetsOfMe {
    let count: Int?
    let sinceId: String?
    let maxId: String?
    let trimUser: Bool?
    let includeEntities: Bool?
    let includeUserEntities: Bool?
}


/**
 GET statuses/show/:id

 Returns a single Tweet, specified by the id parameter. The Tweet’s author will also be embedded within the tweet.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/show/id)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetStatusesShow {
    let id: String
    let trimUser: Bool?
    let includeMyRetweet: Bool?
    let includeEntities: Bool?
}


/**
 GET statuses/user_timeline

 Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/user_timeline)

 - Remark: Rate limit: (user) 180 / 15 min | (app) 300 / 15 min
 */
public struct GetStatusesUserTimeline {
    let userId: String?
    let screenName: String?
    let sinceId: String?
    let count: Int?
    let maxId: String?
    let trimUser: Bool?
    let excludeReplies: Bool?
    let contributorDetails: Bool?
    let includeRts: Bool?
}
