//
//  JSONParser.swift
//  NYTimesProject
//
//  Created by JonLu on 10/23/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JSONParser {
    
    static func parseStandardThumbnail(dic: [String: Any]) -> String? {
        let json = JSON(dic)
        return json["multimedia"][1]["url"].string
    }
    
    static func parseStoryMetaData(dic: [String: Any]) -> StoryMetaData {
        
        let storyMetaData = StoryMetaData()
        let json = JSON(dic)
        
        storyMetaData.status = json["status"].string
        storyMetaData.section = json["section"].string
        storyMetaData.lastUpdated = json["last_updated"].string
        storyMetaData.numberOfResults = json["num_results"].int
        
        return storyMetaData
    }
    
    static func parseLastUpdateTimeStamp(dic: [String: Any]) -> String {
        let json = JSON(dic)
        return json["last_updated"].string!
    }
}
