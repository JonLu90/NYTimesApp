//
//  NYTSearchViewController.swift
//  NYTimesProject
//
//  Created by JonLu on 10/24/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit


class NYTSearchViewController: UIViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchQueryData(query: "google", page: 10)
    }
    
    func fetchQueryData(query: String, page: Int) {
        
        NetworkService.queryRequest(target: .articleSearch(["q": query, "page": page]), success: { (response) in
            print(try! response.mapJSON())
        }) { (error) in
            print(error)
        }
    }
}
