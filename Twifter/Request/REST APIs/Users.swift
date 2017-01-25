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
public struct GetUsersLookup {
    let screenName: String?
    let userId: String?
    let include_entities: Bool?
}


/**
 GET users/profile_banner

 Returns a map of the available size variations of the specified user’s profile banner. If the user has not uploaded a profile banner, a HTTP 404 will be served instead.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/profile_banner)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetUsersProfileBanner {
    let userId: String?
    let screenName: String?
}


/**
 GET users/search

 Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria. Exact match searches are not supported.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/search)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetUsersSearch {
    let q: String
    let page: Int?
    let count: Int?
    let includeEntities: Bool?
}


/**
 GET users/show

 Returns a variety of information about the user specified by the required user_id or screen_name parameter. The author’s most recent Tweet will be returned inline when possible.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/show)

 - Remark: Rate limit: 180 / 15 min
 */
public struct GetUsersShow {
    let userId: String?
    let screenName: String?
    let includeEntities: Bool?
}


/**
 GET users/suggestions

 Access to Twitter’s suggested user list. This returns the list of suggested user categories. The category can be used in GET users / suggestions / :slug to get the users in that category.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/suggestions)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetUsersSuggestions {
    let slug: String?
    let lang: String?
}


/**
 GET users/suggestions/:slug/members

 Access the users in a given category of the Twitter suggested user list and return their most recent status if they are not a protected user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/users/suggestions/slug/members)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetUsersSuggestionsMembers {
    let slug: String
}
