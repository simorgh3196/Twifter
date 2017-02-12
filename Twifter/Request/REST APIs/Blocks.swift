//
//  Blocks.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


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
public struct GetBlocksIds: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/blocks/ids.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "stringify_ids": stringifyIds,
            "cursor": cursor
            ])
    }

    public let credential: Credential
    public let stringifyIds: Bool?
    public let cursor: String?

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
public struct GetBlocksList: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/blocks/list.json"

    public var queryParameters: [String: Any] {
        return query(from: [
            "include_entities": includeEntities,
            "skip_status": skipStatus,
            "include_email": includeEmail
            ])
    }

    public let credential: Credential
    public let includeEntities: Bool?
    public let skipStatus: Bool?
    public let includeEmail: Bool?
}
