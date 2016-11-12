//
//  Twifter.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/10/29.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import APIKit
import Result


public class Twifter {

    public var credential: Credential?

    public func fetchOAuthRequestToken(handler: @escaping (Result<URL, SessionTaskError>) -> Void) {
        let request = FetchOAuthRequestToken(credential: credential!, callbackURL: nil)
        Session.send(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.credential?.accessToken = response.token
                handler(.success(response.url))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

    public func fetchOAuthAccessToken(verifier: String, handler: @escaping (Result<Void, SessionTaskError>) -> Void) {
        let request = FetchOAuthAccessToken(credential: credential!, verifier: verifier)
        Session.send(request) { [weak self] result in
            switch result {
            case .success(let accessToken):
                self?.credential?.accessToken = accessToken
                handler(.success())
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

}
