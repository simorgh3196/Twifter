//
//  Account.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**  
 GET account/settings

 Returns settings (including current trend, geo and sleep time information) for the authenticating user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/account/settings)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetAccountSettings {
}


/**  
 GET account/verify_credentials

 Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; returns a 401 status code and an error message if not. Use this method to test if supplied user credentials are valid.
 [Read more ...](https://dev.twitter.com/rest/reference/get/account/verify_credentials)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetAccountVerifyCredentials {
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
