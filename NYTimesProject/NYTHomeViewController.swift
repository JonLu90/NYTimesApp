//
//  NYTHomeViewController.swift
//  NYTimesProject
//
//  Created by JonLu on 10/22/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit

class NYTHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blue
        
        NetworkService.request(target: .topStoriesHome, success: { (response) in
            print(try! response.mapJSON())
        }) { (error) in
            print(error)
        }
    }
}
