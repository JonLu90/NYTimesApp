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
    
    let storyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return collectionView
    }()
    
    let cellIdentifier = "storyCollectionViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        configure()
        
        // async call!
        NetworkAdapter.request(target: .topStoriesHome, success: { (response) in
            
            let json = try! response.mapJSON() as! [String: Any]
            let results = json["results"] as! [[String: Any]]
                
            for result in results {
                let story = Story(JSON: result)
                // parse standard thumbnail
                if let url = JSONParser.parseStandardThumbnail(dic: result) {
                    story?.thumbnailURL = url
                }
                self.stories.append(story!)
            }
            
            for ele in self.stories {
                print(ele.abstract)
                print(ele.thumbnailURL)
            }
            print(self.stories.count)
            self.storyCollectionView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Home")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    func setupUI() {
        
        self.view.addSubview(storyCollectionView)
        storyCollectionView.backgroundColor = UIColor.white
    }
    
    func setupConstraints() {
        
        storyCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview().offset(0)
        }
    }
    
    func configure() {
        
        storyCollectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
    }
}

extension NYTHomeTopStoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StoryCollectionViewCell {
            cell.configureCellData(stories[indexPath.row])
            return cell
        }
        else {
            return StoryCollectionViewCell()
        }
    }
}
