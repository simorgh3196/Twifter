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

    public var headerFields: [String: String] {
//        let oauthHeaderFields = buildOAuthHeaderFields()
//        let defaultHeaderFields: [String: String] = [
//            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
//        ]
        return buildOAuthHeaderFields()
    }

    public var additionalHeaderFields: [String: String] {
        return [:]
    }

    public func buildOAuthHeaderFields() -> [String: String] {
        var oauthParams: [String: String] = [
            "oauth_version": OAuth.version,
            "oauth_signature_method": OAuth.signatureMethod,
            "oauth_consumer_key": Credential.consumerToken.token,
            "oauth_timestamp": String(Int(Date().timeIntervalSince1970)),
            "oauth_nonce": UUID().uuidString
        ]

        if let oauthToken = credential.accessToken?.token {
            oauthParams["oauth_token"] = oauthToken
        }

        var parameters = oauthParams.push(dictionary: additionalHeaderFields)
        parameters["oauth_signature"] = buildOAuthSignature(parameters: parameters)

        let headerComponents = parameters
            .map {
                let key = $0.urlEncoded()
                let value = "\"" + $1.urlEncoded(encodeAll: key == "status") + "\""
                return key + "=" + value
            }
            .sorted()
            .joined(separator: ", ")

        return ["Authorization": "OAuth " + headerComponents]
    }

    private func buildOAuthSignature(parameters: [String: String]) -> String {
        let encodedParameter = parameters
            .map { $0.urlEncoded() + "=" + $1.urlEncoded() }
            .sorted()
            .joined(separator: "&")
            .urlEncoded()
        let encodedURL = (baseURL.absoluteString + path).urlEncoded()
        let signatureBase = "\(method.rawValue)&\(encodedURL)&\(encodedParameter)"
        let base = signatureBase.data(using: .utf8)!

        let consumerSecret = Credential.consumerToken.secret.urlEncoded()
        let tokenSecret = credential.accessToken?.secret.urlEncoded() ?? ""
        let keyString = "\(consumerSecret)&\(tokenSecret)"
        let key = keyString.data(using: .utf8)!

        let sha1 = HMAC.sha1(key: key, message: base)!

        return sha1.base64EncodedString()
    }

}
