//
//  Projects.swift
//  Pods
//
//  Created by Tomoya Hayakawa on 2016/11/08.
//
//

import Foundation


/**
 GET projects

 This endpoint requires special permission to access and is only available for TV broadcast use cases. To request access please visit curator.twitter.com.
 [Read more ...](https://dev.twitter.com/rest/reference/get/projects)
 
 - Remark: Rate limit: 900 / 15 min
 */
public struct GetProjects {
    let limit: Int?
    let format: Format?
    let auth: String


    public enum Format: String {
        case json, xml
    }
}
