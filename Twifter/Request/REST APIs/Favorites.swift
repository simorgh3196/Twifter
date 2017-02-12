//
//  Favorites.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET favorites/list

 Returns the 20 most recent Tweets favorited by the authenticating or specified user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/favorites/list)

 __Rate limit__: 15 / 15 min
 */
public struct GetFavoritesList {
    let userId: String?
    let screenName: String?
    let count: Int?
    let sinceId: String?
    let maxId: String?
    let includeEntities: Bool?
}
