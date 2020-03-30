//
//  API.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

open class API {

    public typealias CompletionHandler<T> = ((Result<T, TwifterError>) -> Void)

    public let session: URLSession
    public var oauthSigner: OAuthSigner

    public init(session: URLSession = .shared, oauthSigner: OAuthSigner) {
        self.session = session
        self.oauthSigner = oauthSigner
    }

    @discardableResult
    open func send<R: Request>(_ request: R,
                               completionHandler: @escaping CompletionHandler<R.Response>) -> CancellableTask {
        let urlRequest = oauthSigner.sign(to: request)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(.failure(.networkError(reason: .catchError(error))))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.networkError(reason: .invalidResponse(response))))
                return
            }

            guard request.acceptableStatusCodes.contains(urlResponse.statusCode) else {
                completionHandler(.failure(.networkError(reason: .unacceptableStatusCode(urlResponse.statusCode))))
                return
            }

            do {
                try request.decodeResponse(data: data ?? Data(), urlResponse: urlResponse) { object in
                    completionHandler(.success(object))
                }
            } catch {
                completionHandler(.failure(.networkError(reason: .decodeFailed(error))))
            }
        }
        task.resume()

        return task
    }
}
