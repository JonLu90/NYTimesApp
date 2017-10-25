//
//  SearchStoryData.swift
//  NYTimesProject
//
//  Created by JonLu on 10/25/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import ObjectMapper


class SearchStory: Mappable {
    
    var webURL: String?
    var snippet: String?
    var thumbnailURL: String?
    var headline: String?
    var date: String?
    
    required init?(map: Map) {}
    
    // thumbnail URL CAN NOT be mapped
    // And headline mapping always fail, still figuring out why
    // for those 2 properties, use swiftyJson instead
    func mapping(map: Map) {
        
        webURL  <- map["web_url"]
       snippet  <- map["snippet"]
          date  <- map["pub_date"]
    }
}
