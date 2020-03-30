//
//  TwitterEndpoint.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public struct TwitterEndpoint<Response: Decodable, Decoder: ResponseDecoder>: Request {

    public var baseURL: URL { URL(string: "https://api.twitter.com")! }

    public var path: String

    public var method: HTTPMethod

    public var headerFields: [String: String]? = nil

    public var queryParameters: [String: String]? = nil

    public var bodyParameters: [String: Any]? = nil

    public var decoder: Decoder = .default

    public func decodeResponse(data: Data,
                               urlResponse: HTTPURLResponse,
                               completionHandler: @escaping ((Response) -> Void)) throws {
        guard acceptableStatusCodes.contains(urlResponse.statusCode) else {
            throw try decoder.decode(as: TwitterAPIError.self, from: data, urlResponse: urlResponse)
        }

        let response = try decoder.decode(as: Response.self, from: data, urlResponse: urlResponse)
        completionHandler(response)
    }
}

extension API {

    @discardableResult
    open func call<Response, Decoder>(_ endpoint: TwitterEndpoint<Response, Decoder>,
                                      completionHandler: @escaping CompletionHandler<Response>) -> CancellableTask {
        return send(endpoint, completionHandler: completionHandler)
    }
}
