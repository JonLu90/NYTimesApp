//
//  Networking.swift
//  NYTimesProject
//
//  Created by JonLu on 10/22/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import Moya


struct NetworkService {
    
    static let provider = MoyaProvider<NYTimesAPI>()
    
    static func request(target: NYTimesAPI, success successCallback: @escaping (Response) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
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
    
//    static func isConnectedToInternet() -> Bool {
//
//    }
}
