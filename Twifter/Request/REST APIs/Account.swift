//
//  Account.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit

// MARK: - GET Request

/**
 GET account/settings

 Returns settings (including current trend, geo and sleep time information) for the authenticating user.
 [Read more ...](https://dev.twitter.com/rest/reference/get/account/settings)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetAccountSettings: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/account/settings.json"

    public let credential: Credential
}


/**
 GET account/verify_credentials

 Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; returns a 401 status code and an error message if not. Use this method to test if supplied user credentials are valid.
 [Read more ...](https://dev.twitter.com/rest/reference/get/account/verify_credentials)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetAccountVerifyCredentials: RestApiRequest {
    public let method: HTTPMethod = .get
    public let path = "/account/verify_credentials.json"

    public var queryParameters: [String : Any] {
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

// MARK: - POST Request

/**
 POST account/remove_profile_banner

 Removes the uploaded profile banner for the authenticating user. Returns HTTP 200 upon success.
 [Read more ...](https://dev.twitter.com/rest/reference/post/account/remove_profile_banner)
 */
public struct PostAccountRemoveProfileBanner: RestApiRequest {
    public let method: HTTPMethod = .post
    public let path = "/account/remove_profile_banner.json"

    public let credential: Credential
}

/**
 POST account/settings

 Updates the authenticating user’s settings.
 [Read more ...](https://dev.twitter.com/rest/reference/post/account/settings)
 */
public struct PostAccountSettings: RestApiRequest {
    public let method: HTTPMethod = .post
    public let path = "/account/settings.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "sleep_time_enabled": sleepTimeEnabled,
            "start_sleep_time": startSleepTime,
            "end_sleep_time": endSleepTime,
            "time_zone": timeZone,
            "trend_location_woeid": trendLocationWoeid,
            "lang": lang
            ])
    }

    public let credential: Credential
    public let sleepTimeEnabled: Bool?
    public let startSleepTime: Int?
    public let endSleepTime: Int?
    public let timeZone: String?
    public let trendLocationWoeid: Int?
    public let lang: String?
}

/**
 POST account/update_profile

 Sets some values that users are able to set under the “Account” tab of their settings page. Only the parameters specified will be updated.
 [Read more ...](https://dev.twitter.com/rest/reference/post/account/update_profile)
 */
public struct PostAccountUpdateProfile: RestApiRequest {
    public let method: HTTPMethod = .post
    public let path = "/account/update_profile.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "name": name,
            "url": url,
            "location": location,
            "description": description,
            "profile_link_color": profileLinkColor,
            "include_entities": includeEntities,
            "skip_status": skipStatus
            ])
    }

    public let credential: Credential
    public let name: String?
    public let url: String?
    public let location: String?
    public let `description`: String?
    public let profileLinkColor: String?
    public let includeEntities: Bool?
    public let skipStatus: Bool?
}

/**
 POST account/update_profile_background_image

 Updates the authenticating user’s profile background image. This method can also be used to enable or disable the profile background image.
 [Read more ...](https://dev.twitter.com/rest/reference/post/account/update_profile_background_image)
 */
public struct PostAccountUpdateProfileBackgroundImage: RestApiRequest {
    public let method: HTTPMethod = .post
    public let path = "/account/update_profile_background_image.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "image": image,
            "tile": tile,
            "include_entities": includeEntities,
            "skip_status": skipStatus,
            "media_id": mediaId
            ])
    }

    public let credential: Credential
    public let image: String?
    public let tile: Bool?
    public let includeEntities: Bool?
    public let skipStatus: Bool?
    public let mediaId: String?
}

/**
 POST account/update_profile_banner

 Uploads a profile banner on behalf of the authenticating user. More information about sizing variations can be found in User Profile Images and Banners and GET users / profile_banner.
 [Read more ...](https://dev.twitter.com/rest/reference/post/account/update_profile_banner)
 */
public struct PostAccountUpdateProfileBanner: RestApiRequest {
    public let method: HTTPMethod = .post
    public let path = "/account/update_profile_background_image.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "banner": banner,
            "width": width,
            "height": height,
            "offset_left": offsetLeft,
            "offset_top": offsetTop
            ])
    }

    public let credential: Credential
    public let banner: String
    public let width: Int?
    public let height: Int?
    public let offsetLeft: Int?
    public let offsetTop: Int?
}

/**
 POST account/update_profile_image

 Updates the authenticating user’s profile image. Note that this method expects raw multipart data, not a URL to an image.
 [Read more ...](https://dev.twitter.com/rest/reference/post/account/update_profile_image)
 */
public struct PostAccountUpdateProfileImage: RestApiRequest {
    public let method: HTTPMethod = .post
    public let path = "/account/update_profile_image.json"

    public var queryParameters: [String : Any] {
        return query(from: [
            "image": image,
            "include_entities": includeEntities,
            "skip_status": skipStatus
            ])
    }

    public let credential: Credential
    public let image: String?
    public let includeEntities: Bool?
    public let skipStatus: Bool?
}
