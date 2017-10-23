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
    }
}

extension NYTSwipeableBaseViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        let redVC = NYTHomeTopStoriesViewController()
        redVC.view.backgroundColor = UIColor.red
        
        let blueVC = NYTWorldTopStoriesViewController()
        blueVC.view.backgroundColor = UIColor.blue
        
        let greenVC = NYTTechnologyTopStoriesViewController()
        greenVC.view.backgroundColor = UIColor.green
        
        return [redVC, blueVC, greenVC]
    }
}
