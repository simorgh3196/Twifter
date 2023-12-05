//
//  OAuthSignerSpec.swift
//  CoreTests
//
//  Created by Tomoya Hayakawa on 2020/03/30.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Nimble
import Quick
@testable import Twifter

class OAuthSignerSpec: QuickSpec {
    override class func spec() {
        let credentialForTest = Credential(consumerKey: "xvz1evFS4wEEPTGEFPHBog",
                                           consumerSecret: "kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw")
        let accessTokenForTest = AccessToken(oauthToken: "370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb",
                                             oauthTokenSecret: "LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE")
        let requestForTest = TwitterEndpoint<OAuthRequestToken>(
            baseURL: .v1_api,
            path: "/statuses/update.json",
            method: .post,
            queryParameters: ["include_entities": "\(true)"],
            bodyParameters: ["status": "Hello Ladies + Gentlemen, a signed OAuth request!"]
        )
        let signer = OAuth1Signer(credential: credentialForTest,
                                  accessToken: accessTokenForTest,
                                  timestampGenerator: { 1318622958 },
                                  nonceGenerator: { "kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg" })

        describe("create signatre key") {
            it("has credential and access token") {
                let signer = OAuth1Signer(credential: credentialForTest, accessToken: accessTokenForTest)
                expect(signer.signatureKey).to(equal(
                    "kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw&LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE"
                ))
            }

            it("has only credential") {
                let signer = OAuth1Signer(credential: credentialForTest, accessToken: nil)
                expect(signer.signatureKey).to(equal("kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw&"))
            }
        }

        it("make parameters for signature") {
            let parameters = signer.makeParameters(for: requestForTest)

            expect(parameters["status"]).to(equal("Hello Ladies + Gentlemen, a signed OAuth request!"))
            expect(parameters["include_entities"]).to(equal("true"))
            expect(parameters["oauth_consumer_key"]).to(equal("xvz1evFS4wEEPTGEFPHBog"))
            expect(parameters["oauth_nonce"]).to(equal("kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"))
            expect(parameters["oauth_signature_method"]).to(equal("HMAC-SHA1"))
            expect(parameters["oauth_token"]).to(equal("370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb"))
            expect(parameters["oauth_timestamp"]).to(equal("1318622958"))
            expect(parameters["oauth_version"]).to(equal("1.0"))
        }

        it("collect parameters") {
            let parameters = signer.makeParameters(for: requestForTest)

            let parameterString = signer.collect(parameters: parameters)

            let expectedValue = "include_entities=true"
                + "&oauth_consumer_key=xvz1evFS4wEEPTGEFPHBog"
                + "&oauth_nonce=kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"
                + "&oauth_signature_method=HMAC-SHA1"
                + "&oauth_timestamp=1318622958"
                + "&oauth_token=370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb"
                + "&oauth_version=1.0"
                + "&status=Hello%20Ladies%20%2B%20Gentlemen%2C%20a%20signed%20OAuth%20request%21"
            expect(parameterString).to(equal(expectedValue))
        }

        it("make signature base string") {
            let parameters = signer.makeParameters(for: requestForTest)
            let parameterString = signer.collect(parameters: parameters)

            let signatureBaseString = signer.signatureBase(for: requestForTest, parameterString: parameterString)

            let expectedValue = "POST"
                + "&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2Fupdate.json"
                + "&include_entities%3Dtrue"
                + "%26oauth_consumer_key%3Dxvz1evFS4wEEPTGEFPHBog"
                + "%26oauth_nonce%3DkYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"
                + "%26oauth_signature_method%3DHMAC-SHA1"
                + "%26oauth_timestamp%3D1318622958"
                + "%26oauth_token%3D370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb"
                + "%26oauth_version%3D1.0"
                + "%26status%3DHello%2520Ladies%2520%252B%2520Gentlemen%252C%2520a%2520signed%2520OAuth%2520request%2521"
            expect(signatureBaseString).to(equal(expectedValue))
        }

        it("calcurate signature") {
            let parameterString = signer.collect(parameters: signer.makeParameters(for: requestForTest))
            let signatureBaseString = signer.signatureBase(for: requestForTest, parameterString: parameterString)

            let signature = signer.calculateSignature(base: signatureBaseString, key: signer.signatureKey)

            expect(signature).to(equal("hCtSmYh+iHYCEqBWrE7C7hYmtUk="))
        }

        it("sign request") {
            let urlRequest = try signer.sign(to: requestForTest)

            let authorizationHeaderValue = urlRequest.allHTTPHeaderFields!["Authorization"]!

            let expectedValue = "OAuth "
                + #"oauth_consumer_key="xvz1evFS4wEEPTGEFPHBog", "#
                + #"oauth_nonce="kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg", "#
                + #"oauth_signature="hCtSmYh%2BiHYCEqBWrE7C7hYmtUk%3D", "#
                + #"oauth_signature_method="HMAC-SHA1", "#
                + #"oauth_timestamp="1318622958", "#
                + #"oauth_token="370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb", "#
                + #"oauth_version="1.0""#
            expect(authorizationHeaderValue).to(equal(expectedValue))
        }
    }
}
