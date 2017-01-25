//
//  Help.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET help/configuration

 Returns the current configuration used by Twitter including twitter.com slugs which are not usernames, maximum photo resolutions, and t.co shortened URL length.
 [Read more ...](https://dev.twitter.com/rest/reference/get/help/configuration)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetHelpConfiguration {
}


/**
 GET help/languages

 Returns the list of languages supported by Twitter along with the language code supported by Twitter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/help/languages)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetHelpLanguages {
}


/**
 GET help/privacy

 Returns [Twitter’s Privacy Policy](https://twitter.com/privacy).
 [Read more ...](https://dev.twitter.com/rest/reference/get/help/privacy)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetHelpPrivacy {
}


/**
 GET help/tos

 Returns the Twitter Terms of Service. Note: these are not the same as the Developer Policy.
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetHelpTos {
}
