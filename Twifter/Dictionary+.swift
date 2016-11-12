//
//  Dictionary+.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/30.
//  Copyright © 2016年 simorgh. All rights reserved.
//


extension Dictionary {

    func push(dictionary: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var dic = Dictionary<Key, Value>()
        for (key, value) in self {
            dic[key] = value
        }
        for (key, value) in dictionary {
            dic[key] = value
        }
        return dic
    }

}
