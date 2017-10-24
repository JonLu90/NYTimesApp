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

enum NYTimesTopStoriesAPI {
    case topStoriesHome
    // add more for Top Stories API here
    // for example:
    // case topStoriesWorld

}

enum NYTimesSearchAPI {
    case articleSearch([String: Any])
    // add more for Search API here
}

extension NYTimesSearchAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc/search/v2")!
    }
    
    var path: String {
        switch self {
        case .articleSearch:
            return "articlesearch.json"
        }
        // add more API here
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
        switch self {
        case .articleSearch(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    var validate: Bool {
        return false
    }
    
    var headers: [String: String]? {
        return ["api-key": myAPIKey]
    }
    
}

extension NYTimesTopStoriesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc/topstories/v2")!
    }
    
    var path: String {
        switch self {
        case .topStoriesHome:
            return "home.json"
            // add more API here
            // for example:
            // case .topStoriesWorld:
            //    return "world.json"
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
