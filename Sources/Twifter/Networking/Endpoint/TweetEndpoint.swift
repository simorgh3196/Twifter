//
//  TweetEndpoint.swift
//
//
//  Created by simorgh3196 on 2023/12/01.
//

import Foundation
import OpenAPITwitterClient

extension TwitterEndpoint {
    public static func createTweet(
        directMessageDeepLink: String? = nil,
        forSuperFollowersOnly: Bool? = nil,
        geoPlaceID: String? = nil,
        mediaIDs: [String]? = nil,
        mediaTaggedUserIDs: [String]? = nil,
        pollDurationMinutes: Int? = nil,
        pollOptions: [String]? = nil,
        quoteTweetID: String? = nil,
        replyExcludeReplyUserIDs: [String]? = nil,
        replyInReplyToTweetID: String? = nil,
        replySettings: [String]? = nil,
        text: String
    ) -> TwitterEndpoint<Void> {
        .init(
            baseURL: .v2_api,
            path: "/tweets",
            method: .post,
            bodyParameters: ([
              "direct_message_deep_link": directMessageDeepLink,
              "for_super_followers": forSuperFollowersOnly,
              "geo": [
                "place_id": geoPlaceID,
              ],
              "media": [
                "media_ids": mediaIDs,
                "tagged_user_ids": mediaTaggedUserIDs,
              ],
              "poll": ([
                "duration_minutes": pollDurationMinutes,
                "options": pollOptions,
              ] as [String: Any?]).compactMapValues { $0 },
              "quote_tweet_id": quoteTweetID,
              "reply": ([
                "exclude_reply_user_ids": replyExcludeReplyUserIDs,
                "in_reply_to_tweet_id": replyInReplyToTweetID,
              ] as [String: Any?]).compactMapValues { $0 },
              "reply_settings": replySettings,
              "text": text
            ] as [String: Any?]).compactMapValues { $0 }
        )
    }
}
