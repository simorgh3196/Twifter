//
//  Help.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET help/configuration

 Returns the current configuration used by Twitter including twitter.com slugs which are not usernames, maximum photo resolutions, and t.co shortened URL length.
 [Read more ...](https://dev.twitter.com/rest/reference/get/help/configuration)

 __Rate limit__: 15 / 15 min
 */
public struct GetHelpConfiguration {
}


/**
 GET help/languages

 Returns the list of languages supported by Twitter along with the language code supported by Twitter.
 [Read more ...](https://dev.twitter.com/rest/reference/get/help/languages)

 __Rate limit__: 15 / 15 min
 */
public struct GetHelpLanguages {
}


/**
 GET help/privacy

 Returns [Twitter’s Privacy Policy](https://twitter.com/privacy).
 [Read more ...](https://dev.twitter.com/rest/reference/get/help/privacy)

 __Rate limit__: 15 / 15 min
 */
public struct GetHelpPrivacy {
}


/**
 GET help/tos

 Returns the Twitter Terms of Service. Note: these are not the same as the Developer Policy.

 __Rate limit__: 15 / 15 min
 */
public struct GetHelpTos {
}
