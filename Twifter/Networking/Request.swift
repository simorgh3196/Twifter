//
//  Request.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public protocol Request {

    associatedtype Response

    var baseURL: URL { get }

    var path: String { get }

    /// The HTTP request method of the receiver.
    var method: HTTPMethod { get }

    // MARK: Optional

    var requestURL: URL { get }

    /// A dictionary containing all the HTTP header fields of the receiver.
    var headerFields: [String: String]? { get }

    var queryParameters: [String: String]? { get }

    var bodyParameters: [String: String]? { get }

    /// The cache policy for the request.
    var cachePolicy: URLRequest.CachePolicy { get }

    /// The timeout interval for the request. See the commentary for the `timeoutInterval` for more information on timeout intervals.
    var timeoutInterval: TimeInterval { get }

    var acceptableStatusCodes: Range<Int> { get }

    /// Creates a URLRequest with the properties.
    func buildURLRequest() -> URLRequest

    func decodeResponse(data: Data,
                        urlResponse: HTTPURLResponse,
                        completionHandler: @escaping ((Response) -> Void)) throws
}

public extension Request {

    var requestURL: URL { baseURL.appendingPathComponent(path) }

    var headerFields: [String: String]? { nil }

    var queryParameters: [String: String]? { nil }

    var bodyParameters: [String: String]? { nil }

    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }

    var timeoutInterval: TimeInterval { 60.0 }

    var acceptableStatusCodes: Range<Int> { 200..<400 }

    func buildURLRequest() -> URLRequest {
        var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)!
        components.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        let url = components.url!

        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headerFields
        request.httpBody = bodyParameters?
            .filter { !$0.key.contains("oauth_callback") }
            .map { $0.key.urlEncoded + "=" + "\($0.value)".urlEncoded }
            .joined(separator: "&")
            .data(using: .utf8)

        return request
    }
}
