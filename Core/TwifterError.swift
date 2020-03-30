//
//  TwifterError.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public enum TwifterError: LocalizedError {

    public enum NetworkErrorReason {
        case invalidResponse(URLResponse?)
        case unacceptableStatusCode(Int)
        case catchError(Error)
        case decodeFailed(Error)
    }

    public enum LoginErrorReason {
        case doNotHaveTwitterApp
        case cannotGetCallbackURL
        case invalidCallbackURL
        case catchError(Error)
        case cancelled
    }

    case networkError(reason: NetworkErrorReason)

    case loginError(reason: LoginErrorReason)

    /// An error not defined in the Twifter occurred.
    case underlyingError(error: Error)
}
