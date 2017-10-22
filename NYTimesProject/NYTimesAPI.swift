//
//  NYTimesAPI.swift
//  NYTimesProject
//
//  Created by JonLu on 10/22/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import Foundation
import Moya


let myAPIKey = "a353de8ce48a47b9b32f7d2887ad2fb7"

enum NYTimesAPI {
    
    case topStoriesHome
}

extension NYTimesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc/topstories/v2")!
    }
    
    var path: String {
        switch self {
        case .topStoriesHome:
            return "home.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var validate: Bool {
        return false
    }
    
    var headers: [String: String]? {
        return ["api-key": myAPIKey]
    }
}
