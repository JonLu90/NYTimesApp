//
//  NYTSwipeableBaseViewController.swift
//  NYTimesProject
//
//  Created by JonLu on 10/23/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import EZSwipeController
import UIKit


class NYTSwipeableBaseViewController: EZSwipeController {
    
    override func setupView() {
        datasource = self
        navigationBarShouldNotExist = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
}

extension NYTSwipeableBaseViewController: EZSwipeControllerDataSource {
    
    func viewControllerData() -> [UIViewController] {
        
        let homeTopStoriesViewController = NYTHomeTopStoriesViewController()
        let homeTopStoriesNavigationController = UINavigationController(rootViewController: homeTopStoriesViewController)
        
        let searchViewController = NYTSearchViewController()
        let searchViewNavigationController = UINavigationController(rootViewController: searchViewController)
        
        return [homeTopStoriesNavigationController, searchViewNavigationController]
    }
}
