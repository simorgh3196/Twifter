//
//  TwitterURL.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2020/03/31.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public enum TwitterBaseURL {
    case v1_api
    case v1_upload
    case v1_stream
    case v1_userStream
    case v1_siteStream
    case v2_api
    case oauth1
    case publish

    var url: URL {
        switch self {
        case .v1_api:
            return URL(string: "https://api.twitter.com/1.1")!
        case .v1_upload:
            return URL(string: "https://upload.twitter.com/1.1")!
        case .v1_stream:
            return URL(string: "https://stream.twitter.com/1.1")!
        case .v1_userStream:
            return URL(string: "https://userstream.twitter.com/1.1")!
        case .v1_siteStream:
            return URL(string: "https://sitestream.twitter.com/1.1")!
        case .v2_api:
            return URL(string: "https://api.twitter.com/2")!
        case .oauth1:
            return URL(string: "https://api.twitter.com/oauth")!
        case .publish:
            return URL(string: "https://publish.twitter.com")!
        }
    }
}
