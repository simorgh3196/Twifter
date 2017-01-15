//
//  QueryStringDataParser.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2017/01/12.
//
//

import APIKit

/// `QueryStringParser` parses data and convert it to string.
public class QueryStringDataParser: DataParser {
    public enum Error: Swift.Error {
        case invalidData(Data)
        case invalidDataString(String)
    }

    /// The string encoding of the data.
    public let encoding: String.Encoding

    /// Returns `StringDataParser` with the string encoding.
    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }

    // MARK: - DataParser

    /// Value for `Accept` header field of HTTP request.
    public var contentType: String? {
        return nil
    }

    /// Return `String` that converted from `Data`.
    /// - Throws: `StringDataParser.Error` when the parser fails to initialize `String` from `Data`.
    public func parse(data: Data) throws -> Any {
        guard
            let string = String(data: data, encoding: encoding)
            else { throw Error.invalidData(data) }
        return try divideQuery(string: string)
    }

    /// Return `[String: String]` that divided `String`
    private func divideQuery(string: String) throws -> [String: String] {
        // Example Input:
        //     oauth_token=****&oauth_token_secret=****&oauth_callback_confirmed=true
        //     -> ["oauth_token": "****", "oauth_token_secret": "****", "oauth_callback_confirmed": "true"]
        var queries = [String: String]()
        var components = URLComponents()
        components.percentEncodedQuery = string
        components.queryItems?.forEach { item in
            queries[item.name] = item.value
        }

        return queries
    }

}
