//
//  Users.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET users/lookup

 Returns fully-hydrated user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id and/or screen_name parameters.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/lookup)

 - Remark: Rate limit: 15 / 15 min
 - Remark: Rate limit: (user) 180 / 15 min | (app) 60 / 15 min
 */
public struct GetUsersLookup: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/users/lookup.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "screen_name": screenName,
            "user_id": userId,
            "unclude_entities": includeEntities,
            ])
    }

    public let credential: Credential
    public let screenName: String?
    public let userId: String?
    public let includeEntities: Bool?
}


/**
 GET users/profile_banner

 Returns a map of the available size variations of the specified user’s profile banner. If the user has not uploaded a profile banner, a HTTP 404 will be served instead.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/profile_banner)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetUsersProfileBanner: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/users/profile_banner.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "user_id": screenName,
            "screen_name": userId,
            ])
    }

    public let credential: Credential
    public let userId: String?
    public let screenName: String?
}


/**
 GET users/search

 Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria. Exact match searches are not supported.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/search)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetUsersSearch: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/users/search.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "q": q,
            "page": page,
            "count": count,
            "include_entities": includeEntities,
            ])
    }

    public let credential: Credential
    public let q: String
    public let page: Int?
    public let count: Int?
    public let includeEntities: Bool?
}


/**
 GET users/show

 Returns a variety of information about the user specified by the required user_id or screen_name parameter. The author’s most recent Tweet will be returned inline when possible.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/show)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetUsersShow: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/users/show.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "user_id": screenName,
            "screen_name": userId,
            "include_entities": includeEntities,
            ])
    }

    public let credential: Credential
    public let userId: String?
    public let screenName: String?
    public let includeEntities: Bool?
}


/**
 GET users/suggestions

 Access to Twitter’s suggested user list. This returns the list of suggested user categories. The category can be used in GET users / suggestions / :slug to get the users in that category.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/suggestions)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetUsersSuggestions: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/users/suggestions.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "slug": slug,
            "lang": lang,
            ])
    }

    public let credential: Credential
    public let slug: String?
    public let lang: String?
}


/**
 GET users/suggestions/:slug/members

 Access the users in a given category of the Twitter suggested user list and return their most recent status if they are not a protected user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/suggestions/slug/members)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetUsersSuggestionsMembers: RestApiRequest {
    public let method: HTTPMethod = .get
    public var path: String {
        return "/users/suggestions/\(slug)/members.json"
    }

    public var queryParameters: [String: Any] {
        return query(from: [
            "slug": slug,
            ])
    }

    public let credential: Credential
    public let slug: String
}
