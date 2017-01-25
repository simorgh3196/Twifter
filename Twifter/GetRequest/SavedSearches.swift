//
//  SavedSearches.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET saved_searches/list

 Returns the authenticated user’s saved search queries.
 [Read more ...](https://dev.twitter.com/rest/reference/get/saved_searches/list)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetSavedSearchesList {
}


/**
 GET saved_searches/show/:id

 Retrieve the information for the saved search represented by the given id. The authenticating user must be the owner of saved search ID being requested.
 [Read more ...](https://dev.twitter.com/rest/reference/get/saved_searches/show/id)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetSavedSearchesShow {
    let id: String
}
