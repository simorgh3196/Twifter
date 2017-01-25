//
//  Geo.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//  Copyright © 2016年 simorgh3196. All rights reserved.
//

import APIKit


/**
 GET geo/id/:place_id

 Returns all the information about a known [place](https://dev.twitter.com/overview/api/places).
 [Read more ...](https://dev.twitter.com/rest/reference/get/geo/id/place_id)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetGeoId {
    let place_id: String
}


/**
 GET geo/reverse_geocode

 Given a latitude and a longitude, searches for up to 20 places that can be used as a place_id when updating a status.
 [Read more ...](https://dev.twitter.com/rest/reference/get/geo/reverse_geocode)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetGeoReverseGeocode {
    let lat: Double
    let long: Double
    let accuracy: String?
    let granularity: String?
    let maxResults: Int?
    let callback: String?
}


/**
 GET geo/search

 Search for places that can be attached to a statuses/update.
 [Read more ...](https://dev.twitter.com/rest/reference/get/geo/search)

 - Remark: Rate limit: 15 / 15 min
 */
public struct GetGeoSearch {
    let lat: Double?
    let long: Double?
    let query: String?
    let ip: String?
    let granularity: String?
    let accuracy: String?
    let maxResults: Int?
    let containedWithin: String?
    let streetAddress: String?
    let callback: String?
}
