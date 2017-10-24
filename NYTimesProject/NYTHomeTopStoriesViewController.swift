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
    var storyMetaData = StoryMetaData()
    
    let refreshControl = UIRefreshControl()
    
    let storyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return collectionView
    }()
    
    let cellIdentifier = "storyCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        
        fetchStoryData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        if #available(iOS 10.0, *) {
            storyCollectionView.refreshControl = refreshControl
        }
        refreshControl.addTarget(self, action: #selector(fetchStoryData), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
    }
    
    func fetchStoryData() {
        // async call!
        NetworkService.request(target: .topStoriesHome, success: { [unowned self](response) in
            
            let json = try! response.mapJSON() as! [String: Any]
            let results = json["results"] as! [[String: Any]]
            
            let lastUpdateTimeStamp = JSONParser.parseLastUpdateTimeStamp(dic: json)
            
            print("old: \(self.stories.count)")
            
            // if server hasn't updated to newest data, DO NOT update
            if self.storyMetaData.lastUpdated != nil && self.storyMetaData.lastUpdated == lastUpdateTimeStamp {
                self.refreshControl.endRefreshing()
                return
            }
            
            // parse story meta data
            self.storyMetaData = JSONParser.parseStoryMetaData(dic: json)
            self.refreshControl.attributedTitle = NSAttributedString(string: "Last update: \(self.storyMetaData.lastUpdated!)")
            
            self.stories = [Story]()
            for result in results {
                let story = Story(JSON: result)
                // parse thumbnail url
                if let url = JSONParser.parseStandardThumbnail(dic: result) {
                    story?.thumbnailURL = url
                }
                self.stories.append(story!)
            }
            
            self.storyCollectionView.reloadData()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            print("new : \(self.stories.count)")
        }) {
            (error) in
            print("error is:")
            print(error.errorDescription)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = URL(string: stories[indexPath.row].shortURL!)!
        let webViewController = NYTWebViewController(url: url)
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
