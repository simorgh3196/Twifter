//
//  TwifterRequest.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/30.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import APIKit


private struct OAuth {
    static let version = "1.0"
    static let signatureMethod = "HMAC-SHA1"
}


public protocol TwifterRequest: Request {
    var credential: Credential { get }
    var additionalHeaderFields: [String: String] { get }
}

extension TwifterRequest {

    public var headerFields: [String : String] {
        return buildHeaderFields()
    }

    public var additionalHeaderFields: [String: String] {
        return [:]
    }

    public func buildHeaderFields() -> [String: String] {
        var oauthParams: [String: Any] = [
            "oauth_version": OAuth.version,
            "oauth_signature_method": OAuth.signatureMethod,
            "oauth_consumer_key": Credential.consumerToken.key,
            "oauth_timestamp": String(Int(Date().timeIntervalSince1970)),
            "oauth_nonce": UUID().uuidString
        ]

        let parameters = oauthParams.push(dictionary: additionalHeaderFields)
        oauthParams["oauth_signature"] = buildOAuthSignature(parameters: parameters)

        let headerComponents = URLEncodedSerialization.string(from: oauthParams)
            .components(separatedBy: "&")
            .sorted()
            .joined(separator: ", ")

        return ["OAuth": headerComponents]
    }

    private func buildOAuthSignature(parameters: [String: Any]) -> String {
        let encodedParameter = URLEncodedSerialization.string(from: parameters)
            .components(separatedBy: "&")
            .sorted()
            .joined(separator: "&")
            .urlEncoded()
        let encodedURL = (baseURL.absoluteString + path).urlEncoded()
        let signatureBase = "\(method.rawValue)&\(encodedURL)&\(encodedParameter)"

        let msg = signatureBase.data(using: .utf8)!
        let sha1 = HMAC.sha1(key: credential.signingKey, message: msg)!

        return sha1.base64EncodedString()
    }

}
