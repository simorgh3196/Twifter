//
//  Search.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET search/tweets

 Returns a collection of relevant Tweets matching a specified query.
 [Read more ...](https://dev.twitter.com/rest/reference/get/search/tweets)

 - Remark: Rate limit: (user) 180 / 15 min | (app) 450 / 15 min
 */
public struct GetSearchTweets {
    let q: String
    let geocode: String?
    let locale: String?
    let resultType: ResultType?
    let count: Int?
    let until: String?
    let sinceId: String?
    let maxId: String?
    let includeEntities: Bool?
    let callback: String?


    public enum ResultType: String {
        case mixed, recent, popular
    }
}
