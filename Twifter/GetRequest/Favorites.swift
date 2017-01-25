//
//  Favorites.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET favorites/list
 
 Returns the 20 most recent Tweets favorited by the authenticating or specified user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/favorites/list)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetFavoritesList {
    let userId: String?
    let screenName: String?
    let count: Int?
    let sinceId: String?
    let maxId: String?
    let includeEntities: Bool?
}
