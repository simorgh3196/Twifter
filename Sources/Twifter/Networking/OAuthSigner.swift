//
//  OAuthSigner.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public protocol OAuthSigning {
    var credential: Credential { get }
    var accessToken: AccessToken? { get }
    func sign<R: Request>(to request: R) throws -> URLRequest
    func updateAccessToken(_ accessToken: AccessToken?)
}

public class OAuth1Signer: OAuthSigning {

    public let credential: Credential
    public var accessToken: AccessToken?

    var signatureKey: String {
        "\(credential.consumerSecret.urlEncoded)&\(accessToken?.oauthTokenSecret.urlEncoded ?? "")"
    }

    private let timestampGenerator: (() -> TimeInterval)
    private let nonceGenerator: (() -> String)

    public init(credential: Credential, accessToken: AccessToken?) {
        self.credential = credential
        self.accessToken = accessToken
        self.timestampGenerator = { Date().timeIntervalSince1970 }
        self.nonceGenerator = { UUID().uuidString }
    }

    init(credential: Credential,
         accessToken: AccessToken?,
         timestampGenerator: @escaping (() -> TimeInterval),
         nonceGenerator: @escaping (() -> String)) {
        self.credential = credential
        self.accessToken = accessToken
        self.timestampGenerator = timestampGenerator
        self.nonceGenerator = nonceGenerator
    }

    public func sign<R: Request>(to request: R) throws -> URLRequest {
        var urlRequest = try request.buildURLRequest()

        var parameters = makeParameters(for: request)
        parameters["oauth_signature"] = makeSignature(for: request, parameters: parameters)

        let value = parameters
            .filter { $0.key.contains("oauth_") }
            .sorted(by: <)
            .map { "\($0.key)=\"\($0.value.urlEncoded)\"" }
            .joined(separator: ", ")

        urlRequest.setValue("OAuth \(value)", forHTTPHeaderField: "Authorization")

        return urlRequest
    }

    public func updateAccessToken(_ accessToken: AccessToken?) {
        self.accessToken = accessToken
    }
}

extension OAuth1Signer {

    func makeParameters<R: Request>(for request: R) -> [String: String] {
        let bodyParams = request.bodyParameters?.mapValues { "\($0)" } ?? [:]
        let queryParams = request.queryParameters ?? [:]
        let oauthParams = [
            "oauth_consumer_key": credential.consumerKey,
            "oauth_nonce": nonceGenerator(),
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": "\(Int(timestampGenerator()))",
            "oauth_version": "1.0"
        ]
        let accessTokenParams = accessToken.map { ["oauth_token": $0.oauthToken] } ?? [:]

        return bodyParams
            .merging(queryParams, uniquingKeysWith: { _, new in new })
            .merging(oauthParams, uniquingKeysWith: { _, new in new })
            .merging(accessTokenParams, uniquingKeysWith: { _, new in new })
    }

    func makeSignature<R: Request>(for request: R, parameters: [String: String]) -> String {
        let parameterString = collect(parameters: parameters)
        let signatureBaseString = signatureBase(for: request, parameterString: parameterString)
        let signature = calculateSignature(base: signatureBaseString, key: signatureKey)

        return signature
    }

    func collect(parameters: [String: String]) -> String {
        // These values need to be encoded into a single string, which will be used later on.
        // The process to build the string is very specific:
        //     1. Percent encode every key and value that will be signed.
        //     2. Sort the list of parameters alphabetically [1] by encoded key [2].
        //     3. For each key/value pair:
        //     4. Append the encoded key to the output string.
        //     5. Append the ‘=’ character to the output string.
        //     6. Append the encoded value to the output string.
        //     7. If there are more key/value pairs remaining, append a ‘&’ character to the output string.
        let parameterString = parameters
            .reduce(into: [:]) { $0[$1.key.urlEncoded] = $1.value.urlEncoded }
            .sorted(by: <)
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")

        return parameterString
    }

    func signatureBase<R: Request>(for request: R, parameterString: String) -> String {
        // To encode the HTTP method, base URL, and parameter string into a single string:
        //     1. Convert the HTTP Method to uppercase and set the output string equal to this value.
        //     2. Append the ‘&’ character to the output string.
        //     3. Percent encode the URL and append it to the output string.
        //     4. Append the ‘&’ character to the output string.
        //     5. Percent encode the parameter string and append it to the output string.
        let methodString = request.method.value
        let encodedURLString = request.requestURL.absoluteString.urlEncoded
        let encodedParameterString = parameterString.urlEncoded
        let signatureBaseString = "\(methodString)&\(encodedURLString)&\(encodedParameterString)"

        return signatureBaseString
    }

    func calculateSignature(base: String, key: String) -> String {
        let signatureData = HMAC(base).data(withKey: key, algorithm: .sha1)
        let signatureBase64 = signatureData.base64EncodedString()

        return signatureBase64
    }
}
