//
//  API.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public class API {

    public var oauthSigner: any OAuthSigning
    public let session: URLSession
    public let serializer: Serializer

    public init(oauthSigner: some OAuthSigning,
                session: URLSession = .shared,
                serializer: Serializer = .default) {
        self.session = session
        self.oauthSigner = oauthSigner
        self.serializer = serializer
    }

    public func send<R: Request>(_ request: R,
                                 options: Options = .init()) async throws -> R.Response where R.Response: Decodable {
        let data = try await data(for: request)
        try Task.checkCancellation()

        do {
            let serializer = options.serializer ?? serializer
            return try serializer.decoder.decode(R.Response.self, from: data)
        } catch {
            throw TwifterError.networkError(reason: .decodeFailed(error))
        }
    }

    public func send<R: Request>(_ request: R) async throws where R.Response == Void {
        let _ = try await data(for: request)
    }

    @discardableResult
    public func send<R: Request>(
        _ request: R,
        options: Options = .init(),
        completion: @escaping (Result<R.Response, any Error>) -> Void
    ) -> Task<R.Response, any Error> where R.Response: Decodable {
        Task {
            do {
                let response = try await send(request, options: options)
                completion(.success(response))
                return response
            } catch {
                completion(.failure(error))
                throw error
            }
        }
    }

    @discardableResult
    public func send<R: Request>(
        _ request: R,
        options: Options = .init(),
        completion: @escaping (Result<Void, any Error>) -> Void
    ) -> Task<Void, any Error> where R.Response == Void {
        Task {
            do {
                try await send(request)
                completion(.success(()))
            } catch {
                completion(.failure(error))
                throw error
            }
        }
    }

    private func data<R: Request>(for request: R) async throws -> Data {
        do {
            let urlRequest = try oauthSigner.sign(to: request)

            let (data, response) = try await session.data(for: urlRequest)
            try Task.checkCancellation()

            guard let urlResponse = response as? HTTPURLResponse else {
                throw TwifterError.networkError(reason: .invalidResponse(response))
            }

            guard request.acceptableStatusCodes.contains(urlResponse.statusCode) else {
                throw TwifterError.networkError(reason: .unacceptableStatusCode(urlResponse.statusCode))
            }

            return data
        } catch let error as TwifterError {
            throw error
        } catch {
            throw TwifterError.networkError(reason: .catchError(error))
        }
    }
}

extension API {
    public struct Serializer {
        public let encoder: JSONEncoder
        public let decoder: JSONDecoder

        public static let `default`: Serializer = {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            return Serializer(encoder: encoder, decoder: decoder)
        }()

        public init(encoder: JSONEncoder, decoder: JSONDecoder) {
            self.encoder = encoder
            self.decoder = decoder
        }
    }

    public struct Options {
        public let serializer: Serializer?

        public init(serializer: Serializer? = nil) {
            self.serializer = serializer
        }
    }
}
