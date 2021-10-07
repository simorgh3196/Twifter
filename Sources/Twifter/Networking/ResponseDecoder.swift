//
//  ResponseDecoder.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/30.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public protocol ResponseDecoder {
    static var `default`: Self { get }
    func decode<Response: Decodable>(as type: Response.Type, from data: Data, urlResponse: HTTPURLResponse) throws -> Response
}

private let jsonDecoderForTwitter: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

// MARK: - TwitterOAuthResponseDecoder

public typealias TwitterOAuthEndpoint<Response: Decodable> = TwitterEndpoint<Response, TwitterOAuthResponseDecoder>

public struct TwitterOAuthResponseDecoder: ResponseDecoder {
    public static var `default` = TwitterOAuthResponseDecoder()

    public func decode<Response: Decodable>(as type: Response.Type,
                                            from data: Data,
                                            urlResponse: HTTPURLResponse) throws -> Response {
        guard let valueString = String(data: data, encoding: .utf8) else {
            throw TwifterError.networkError(reason: .invalidResponse(urlResponse))
        }

        let jsonObject = [String: String](uniqueKeysWithValues:
            valueString
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .map { (key: $0[0], value: $0[1]) }
        )

        let json = try JSONSerialization.data(withJSONObject: jsonObject)
        return try jsonDecoderForTwitter.decode(Response.self, from: json)
    }
}

// MARK: - TwitterJSONResponseDecoder

public typealias TwitterAPIEndpoint<Response: Decodable> = TwitterEndpoint<Response, TwitterJSONResponseDecoder>

public struct TwitterJSONResponseDecoder: ResponseDecoder {
    public static var `default` = TwitterJSONResponseDecoder()

    public func decode<Response: Decodable>(as type: Response.Type,
                                            from data: Data,
                                            urlResponse: HTTPURLResponse) throws -> Response {
        return try jsonDecoderForTwitter.decode(Response.self, from: data)
    }
}
