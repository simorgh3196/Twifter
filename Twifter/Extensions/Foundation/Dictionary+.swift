//
//  Dictionary+.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/12/30.
//  Copyright © 2016年 simorgh. All rights reserved.
//


extension Dictionary {

    func push(dictionary: [Key: Value]) -> [Key: Value] {
        var dic = [Key: Value]()
        for (key, value) in self {
            dic[key] = value
        }
        for (key, value) in dictionary {
            dic[key] = value
        }
        return dic
    }

}


infix operator ++

func ++ <Key, Value>(left: [Key: Value], right: [Key: Value]) -> [Key: Value] {
    var dic = [Key: Value]()
    for (key, value) in left {
        dic[key] = value
    }
    for (key, value) in right {
        dic[key] = value
    }
    return dic
}
