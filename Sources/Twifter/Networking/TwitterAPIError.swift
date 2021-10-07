//
//  TwitterAPIError.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/30.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

public struct TwitterAPIError: Decodable, Error {

    public struct Code: Decodable {
        let code: Int
        let message: String
    }

    let errors: [Code]
}
