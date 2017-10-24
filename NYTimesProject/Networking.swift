//
//  Networking.swift
//  NYTimesProject
//
//  Created by JonLu on 10/22/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import Moya


struct NetworkService {
    
    static func request(target: NYTimesTopStoriesAPI, success successCallback: @escaping (Response) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        let provider = MoyaProvider<NYTimesTopStoriesAPI>()
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
    static func queryRequest(target: NYTimesSearchAPI, success successCallback: @escaping (Response) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        let provider = MoyaProvider<NYTimesSearchAPI>()
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}
