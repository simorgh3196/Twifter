//
//  OAuthRequest.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2017/01/23.
//  Copyright © 2017年 simorgh. All rights reserved.
//

import APIKit

public protocol OAuthRequest: TwifterRequest {
}

extension OAuthRequest {

    public var baseURL: URL {
        return URL(string: "https://api.twitter.com")!
    }

    public var dataParser: DataParser {
        return QueryStringDataParser()
    }

}
