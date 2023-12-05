//
//  TwitterEndpoint.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public struct TwitterEndpoint<Response>: Request {
    public var baseURL: URL

    public var path: String

    public var method: HTTPMethod

    public var headerFields: [String: String]? = nil

    public var queryParameters: [String: String]? = nil

    public var bodyParameters: [String: Any]? = nil

    public init(
        baseURL: TwitterBaseURL,
        path: String,
        method: HTTPMethod,
        headerFields: [String: String]? = nil,
        queryParameters: [String: String]? = nil,
        bodyParameters: [String: Any]? = nil
    ) {
        self.baseURL = baseURL.url
        self.path = path
        self.method = method
        self.headerFields = headerFields
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}

extension API {
    @discardableResult
    public func call<Response: Decodable>(_ endpoint: TwitterEndpoint<Response>) async throws -> Response {
        try await send(endpoint)
    }

    public func call(_ endpoint: TwitterEndpoint<Void>) async throws {
        try await send(endpoint)
    }
}
