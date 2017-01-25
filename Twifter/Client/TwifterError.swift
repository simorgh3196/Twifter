//
//  TwifterError.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/30.
//  Copyright © 2016年 simorgh. All rights reserved.
//

public enum TwifterError: Error {
    case invalidStatusCode
    case invalidResponseData
    case unconnectedNetwork
    case parseFailed
    case urlResponseError
    case badOAuthResponse

}

extension TwifterError: CustomStringConvertible {

    public var description: String {
        switch self {
        default: return ""
        }
    }

}
