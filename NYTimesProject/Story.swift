//
//  Story.swift
//  NYTimesProject
//
//  Created by JonLu on 10/23/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import Foundation
import ObjectMapper

class Story: Mappable{
    
    var section: String?
    var subsection: String?
    var title: String?
    var abstract: String?
    var publishedDate: String?
    var shortURL: String?
    var thumbnailURL: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
            section  <- map["section"]
         subsection  <- map["subsection"]
              title  <- map["title"]
           abstract  <- map["abstract"]
      publishedDate  <- map["published_date"]
           shortURL  <- map["short_url"]
        
    }
}
