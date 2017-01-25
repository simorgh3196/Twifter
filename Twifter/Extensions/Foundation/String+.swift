//
//  String+URLEncode.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/30.
//  Copyright © 2016年 simorgh. All rights reserved.
//


extension String {

    func urlEncoded(encodeAll: Bool = false) -> String {
        var allowedCharacterSet: CharacterSet = .urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\n:#/?@!$&'()*+,;=")
        if !encodeAll {
            allowedCharacterSet.insert(charactersIn: "[]")
        }
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
    }

    func queryItems() -> [String: String]? {
        var components = URLComponents()
        components.percentEncodedQuery = self

        var queryItems = [String: String]()
        components.queryItems?.forEach { item in
            queryItems[item.name] = item.value
        }

        if queryItems.isEmpty {
            return nil
        }

        return queryItems
    }

}
