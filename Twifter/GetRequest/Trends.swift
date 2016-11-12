//
//  Trends.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET trends/available

 Returns the locations that Twitter has trending topic information for.
 [Read more ...](https://dev.twitter.com/rest/reference/get/trends/available)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetTrendsAvailable {
}


/**
 GET trends/closest

 Returns the locations that Twitter has trending topic information for, closest to a specified location.
 [Read more ...](https://dev.twitter.com/rest/reference/get/trends/closest)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetTrendsClosest {
    let lat: Double
    let long: Double
}


/**
 GET trends/place

 Returns the top 10 trending topics for a specific WOEID, if trending information is available for it.
 [Read more ...](https://dev.twitter.com/rest/reference/get/trends/place)
 
 - Remark: Rate limit: 15 / 15 min
 */
public struct GetTrendsPlace {
    let id: Int
    let exclude: [String]
}
