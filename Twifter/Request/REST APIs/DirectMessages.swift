//
//  DirectMessages.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET direct_messages

 Returns the 20 most recent direct messages sent to the authenticating user.
 Includes detailed information about the sender and recipient user.
 You can request up to 200 direct messages per call,
 and only the most recent 200 DMs will be available using this endpoint.
 [Read more ...](https://dev.twitter.com/rest/reference/get/direct_messages)

 - Important:
        This method requires an access token with RWD (read, write & direct message) permissions.
        Consult [The Application Permission Model](https://dev.twitter.com/oauth/overview/application-permission-model) for more information.
 - Remark:
        Rate limit: 15 / 15 min
 */
public struct GetDirectMessages {
    let sinceId: String?
    let maxId: String?
    let count: Int?
    let includeEntities: Bool?
    let skipStatus: Bool?
}


/**
 GET direct_messages

 Returns the 20 most recent direct messages sent by the authenticating user.
 Includes detailed information about the sender and recipient user.
 You can request up to 200 direct messages per call, up to a maximum of 800 outgoing DMs.
 [Read more ...](https://dev.twitter.com/rest/reference/get/direct_messages)

 - Important:
        This method requires an access token with RWD (read, write & direct message) permissions. Consult The Application Permission Model for more information.
 __Rate limit__: 15 / 15 min
 */
public struct GetDirectMessagesSent {
    let sinceId: String?
    let maxId: String?
    let count: Int?
    let page: Int?
    let includeEntities: Bool?
}


/**
 GET direct_messages

 Returns a single direct message, specified by an id parameter.
 Like the /1.1/direct_messages.format request,
 this method will include the user objects of the sender and recipient.
 [Read more ...](https://dev.twitter.com/rest/reference/get/direct_messages)

 - Important:
        This method requires an access token with RWD (read, write & direct message) permissions.
        Consult The Application Permission Model for more information.
 __Rate limit__: 15 / 15 min
 */
public struct GetDirectMessagesMessages {
    let id: String
}
