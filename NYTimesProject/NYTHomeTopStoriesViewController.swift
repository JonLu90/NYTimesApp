//
//  NYTHomeTopStoriesViewController.swift
//  NYTimesProject
//
//  Created by JonLu on 10/23/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit

class NYTHomeTopStoriesViewController: UIViewController {
    
    var stories = [Story]()
    
    override func viewDidLoad() {
        
        NetworkAdapter.request(target: .topStoriesHome, success: { (response) in
            //print(try! response.mapJSON())
            
            let json = try! response.mapJSON() as! [String: Any]
            let results = json["results"] as! [[String: Any]]
                
            for result in results {
                let story = Story(JSON: result)
                // parse standard thumbnail
                if let url = JSONParser.parseStandardThumbnail(dic: result) {
                    story?.standardThumbnailURL = url
                }
                self.stories.append(story!)
            }
            
            for ele in self.stories {
                print(ele.abstract)
                print(ele.standardThumbnailURL)
            }
            print(self.stories.count)
            
        }) { (error) in
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Home")
    }
}
