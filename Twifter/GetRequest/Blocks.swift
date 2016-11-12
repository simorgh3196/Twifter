//
//  Blocks.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET blocks/ids
 
 Returns an array of numeric user ids the authenticating user is blocking.
 [Read more ...](https://dev.twitter.com/rest/reference/get/blocks/ids)
 
 - Important: 
        This method is cursored, meaning your app must make multiple requests in order to receive all blocks correctly.
        See [Using cursors to navigate collections](https://dev.twitter.com/overview/api/cursoring) for more details on how cursoring works.
 - Remark:
        Rate limit: 15 / 15 min
 */
struct GetBlocksIds {
    let stringifyIds: Bool?
    let cursor: Int?

    /**
     GET blocks/ids

     - parameter stringifyIds:
            Many programming environments will not consume our ids due to their size.
            Provide this option to have ids returned as strings instead. Read more about Twitter IDs.
     - parameter cursor:
            Causes the list of IDs to be broken into pages of no more than 5000 IDs at a time.
            The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered
            out after connections are queried.
            If no cursor is provided, a value of -1 will be assumed, which is the first “page.”
            The response from the API will include a previous_cursor and next_cursor to allow paging
            back and forth. See Using cursors to navigate collections for more information.

     - returns: Request
     */
    init(stringifyIds: Bool? = nil, cursor: Int?) {
        self.stringifyIds = stringifyIds
        self.cursor = cursor
    }
}


/**
 GET blocks/list

 Returns a collection of user objects that the authenticating user is blocking.
 [Read more ...](https://dev.twitter.com/rest/reference/get/blocks/list)
 
 
 - Important: 
        This method is cursored, meaning your app must make multiple requests in order to receive all blocks correctly.
        See [Using cursors to navigate collections](https://dev.twitter.com/overview/api/cursoring) for more details on how cursoring works.
 - Remark:
        Rate limit: 15 / 15 min
 */
struct GetBlocksList {
    let includeEntities: Bool?
    let skipStatus: Bool?
    let includeEmail: Bool?

    /**
     GET account/verify_credentials

     - parameter includeEntities:
            The entities node will not be included when set to false.
     - parameter skipStatus:
            When set to either true, t or 1 statuses will not be included in the returned user object.
     - parameter includeEmail:
            Use of this parameter requires whitelisting. 
            When set to true email will be returned in the user objects as a string.
            If the user does not have an email address on their account, 
            or if the email address is un-verified, null will be returned.

     - returns: Request
     */
    init(includeEntities: Bool? = nil, skipStatus: Bool? = nil, includeEmail: Bool? = nil) {
        self.includeEntities = includeEntities
        self.skipStatus = skipStatus
        self.includeEmail = includeEmail
    }
}
