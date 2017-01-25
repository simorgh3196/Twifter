//
//  RestApiRequest.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2017/01/23.
//  Copyright © 2017年 simorgh. All rights reserved.
//

import APIKit

public protocol RestApiRequest: TwifterRequest {
}

extension RestApiRequest {

    public typealias Response = [String: Any]

    public var baseURL: URL {
        return URL(string: "https://api.twitter.com/1.1")!
    }

    public var dataParser: DataParser {
        return JSONDataParser(readingOptions: [])
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [String: Any] {
        guard let json = object as? [String: Any] else {
            throw TwifterError.invalidResponseData
        }

        return json
    }

}
