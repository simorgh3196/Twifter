//
//  Credential.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/25.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import Foundation

typealias TwitterCredential = Credential

public struct Credential: Equatable, Hashable {
    let consumerKey: String
    let consumerSecret: String
}
