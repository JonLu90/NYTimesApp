//
//  JSONParser.swift
//  NYTimesProject
//
//  Created by JonLu on 10/23/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

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
    
    static func parseSearchResults(dic: [String: Any]) -> [[String: Any]] {
        let json = JSON(dic)
        let results = json["response"]["docs"].arrayObject as! [[String: Any]]
        return results
    }
    
    static let thumbnailBaseURL = "https://static01.nyt.com/"
    static func parseSearchStoryThumbnail(dic: [String: Any]) -> String? {
        let json = JSON(dic)
        if let urlString = json["multimedia"][0]["url"].string {
            return thumbnailBaseURL + urlString
        } else {
            return nil
        }
        
    }
    
    static func parseSearchStoryHeadline(dic: [String: Any]) -> String {
        let json = JSON(dic)
        let headline = json["headline"]["main"].string!
        return headline
    }
}
