//
//  TwitterURL.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2020/03/31.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public enum TwitterBaseURL {
    case api
    case upload
    case stream
    case publish
    case userStream
    case siteStream
    case oauth

    var url: URL {
        switch self {
        case .api:
            return URL(string: "https://api.twitter.com/1.1")!
        case .upload:
            return URL(string: "https://upload.twitter.com/1.1")!
        case .stream:
            return URL(string: "https://stream.twitter.com/1.1")!
        case .userStream:
            return URL(string: "https://userstream.twitter.com/1.1")!
        case .siteStream:
            return URL(string: "https://sitestream.twitter.com/1.1")!
        case .oauth:
            return URL(string: "https://api.twitter.com")!
        case .publish:
            return URL(string: "https://publish.twitter.com")!
        }
    }
}
