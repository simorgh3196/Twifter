//
//  Collections.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET collections/entries

 Retrieve the identified Collection, presented as a list of the Tweets curated within.
 [Read more ...](https://dev.twitter.com/rest/reference/get/collections/entries)

 __Rate limit__: 1000 / 15 min
 */
public struct GetCollectionsEntries {
    let id: String
    let count: Int?
    let maxPosition: Int?
    let minPosition: Int?
}


/**
 GET collections/list

 Find Collections created by a specific user or containing a specific curated Tweet.
 [Read more ...](https://dev.twitter.com/rest/reference/get/collections/list)

 __Rate limit__: 1000 / 15 min
 */
public struct GetCollectionsList {
    let userId: String
    let screenName: String
    let tweetId: String?
    let count: Int?
    let cursor: Int?
}


/**
 GET collections/show

 Retrieve information associated with a specific Collection.
 [Read more ...](https://dev.twitter.com/rest/reference/get/collections/show)

 __Rate limit__: 1000 / 15 min
 */
public struct GetCollectionsShow {
    let id: String
}
