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
}
