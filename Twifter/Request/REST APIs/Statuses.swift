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
public struct GetStatusesHomeTimeline: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/statuses/home_timeline.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "count": count,
            "since_id": sinceId,
            "max_id": maxId,
            "trim_user": trimUser,
            "exclude_replies": excludeReplies,
            "include_entities": includeEntities
            ])
    }

    public let credential: Credential
    public let count: Int?
    public let sinceId: String?
    public let maxId: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let includeEntities: Bool?
}


/**
 GET statuses/lookup

 Returns fully-hydrated tweet objects for up to 100 tweets per request, as specified by comma-separated values passed to the id parameter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/lookup)

 - Remark: Rate limit: (user) 180 / 15 min | (app) 60 / 15 min
 */
public struct GetStatusesLookup: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/statuses/lookup.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "id": id,
            "include_entities": includeEntities,
            "trim_user": trimUser,
            "map": map
            ])
    }

    public let credential: Credential
    public let id: String
    public let includeEntities: Bool?
    public let trimUser: Bool?
    public let map: Bool?
}


/**
 GET statuses/mentions_timeline

 Returns the 20 most recent mentions (tweets containing a users’s @screen_name) for the authenticating user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetStatusesMentionsTimeline: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/statuses/mentions_timeline.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "count": count,
            "since_id": sinceId,
            "max_id": maxId,
            "trim_user": trimUser,
            "include_entities": includeEntities
            ])
    }

    public let credential: Credential
    let count: Int?
    let sinceId: String?
    let maxId: String?
    let trimUser: Bool?
    let includeEntities: Bool?
}


/**
 GET statuses/retweeters/ids

 Returns a collection of up to 100 user IDs belonging to users who have retweeted the tweet specified by the id parameter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids)

 - Remark: Rate limit: (user) 15 / 15 min | (app) 60 / 15 min
 */
public struct GetStatusesRetweetersIds: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/statuses/retweeters/ids.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "id": id,
            "cursor": cursor,
            "stringify_ids": stringifyIds
            ])
    }

    public let credential: Credential
    public let id: String
    public let cursor: Int? // semi-optional
    public let stringifyIds: Bool?
}


/**
 GET statuses/retweets/:id

 Returns a collection of the 100 most recent retweets of the tweet specified by the id parameter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/retweets/id)

 - Remark: Rate limit: (user) 15 / 15 min | (app) 60 / 15 min
 */
public struct GetStatusesRetweets: RestApiRequest {
    public let method: HTTPMethod = .get
    public var path: String {
        return "/statuses/retweets/\(id).json"
    }

    public var queryParameters: [String: Any] {
        return query(from: [
            "count": count,
            "trim_user": trimUser
            ])
    }

    public let credential: Credential
    public let id: String
    public let count: Int?
    public let trimUser: Bool?
}


/**
 GET statuses/retweets_of_me

 Returns the most recent tweets authored by the authenticating user that have been retweeted by others. This timeline is a subset of the user’s GET statuses / user_timeline.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetStatusesRetweetsOfMe: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/statuses/retweeters/ids.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "count": count,
            "since_id": sinceId,
            "max_id": maxId,
            "trim_user": trimUser,
            "include_entities": includeEntities,
            "include_user_entities": includeUserEntities
            ])
    }

    public let credential: Credential
    public let count: Int?
    public let sinceId: String?
    public let maxId: String?
    public let trimUser: Bool?
    public let includeEntities: Bool?
    public let includeUserEntities: Bool?
}


/**
 GET statuses/show/:id

 Returns a single Tweet, specified by the id parameter. The Tweet’s author will also be embedded within the tweet.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/show/id)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetStatusesShow: RestApiRequest {
    public let method: HTTPMethod = .get
    public var path: String {
        return "/statuses/show/\(id).json"
    }

    public var queryParameters: [String : Any] {
        return query(from: [
            "trim_user": trimUser,
            "include_my_retweet": includeMyRetweet,
            "include_entities": includeEntities
            ])
    }

    public let credential: Credential
    public let id: String
    public let trimUser: Bool?
    public let includeMyRetweet: Bool?
    public let includeEntities: Bool?
}


/**
 GET statuses/user_timeline

 Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
 [Read more ...](https://dev.twitter.com/rest/reference/get/statuses/user_timeline)

 - Remark: Rate limit: (user) 180 / 15 min | (app) 300 / 15 min
 */
public struct GetStatusesUserTimeline: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/statuses/user_timeline.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "user_id": userId,
            "screen_name": screenName,
            "since_id": sinceId,
            "count": count,
            "max_id": maxId,
            "trim_user": trimUser,
            "exclude_replies": excludeReplies,
            "contributor_details": contributorDetails,
            "include_rts": includeRts
            ])
    }

    public let credential: Credential
    public let userId: String?
    public let screenName: String?
    public let sinceId: String?
    public let count: Int?
    public let maxId: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let contributorDetails: Bool?
    public let includeRts: Bool?
}
