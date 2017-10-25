//
//  NYTSearchViewController.swift
//  NYTimesProject
//
//  Created by JonLu on 10/24/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit
import SnapKit


class NYTSearchViewController: UIViewController {
    
    let textFieldHeaderIdentifier = "textFieldHeaderCell"
    let reusableCellIdentifier = "reusableCellIdentifier"
    
    var page = 0
    var query = ""
    var stories = [SearchStory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("query: \(query)")
        print("story num: \(stories.count)")
    }
    
    func fetchQueryData(query: String, page: Int) {
        
        // async call!
        NetworkService.queryRequest(target: .articleSearch(["q": query, "page": page]), success: { [unowned self](response) in
            
            let json = try! response.mapJSON() as! [String: Any]
            let results = JSONParser.parseSearchResults(dic: json)
            
            // map data model
            // and insert data into story array
            // but before fetch new query data
            // clear story array first
            
            self.stories = []
            for result in results {
                let story = SearchStory(JSON: result)!
                story.thumbnailURL = JSONParser.parseSearchStoryThumbnail(dic: result)
                story.headline = JSONParser.parseSearchStoryHeadline(dic: result)
                self.stories.append(story)
            }
            self.searchCollectionView.reloadData()
            print("story inside async: \(self.stories.count)")
            print("query inside async: \(self.query)")
            
        }) { (error) in
            UtilityFunctions.showAlert(error.errorDescription!)
            print(error)
        }
    }
    
    let searchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    func setupUI() {
        self.view.addSubview(searchCollectionView)
    }
    
    func setupConstraints() {
        searchCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview().offset(0)
        }
    }
    
    func configure() {
        
        searchCollectionView.register(TextFieldHeaderCell.self, forCellWithReuseIdentifier: textFieldHeaderIdentifier)
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: reusableCellIdentifier)
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
    
}

extension NYTSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return stories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.frame.width, height: self.view.frame.width/6)
        }
        else {
            return CGSize(width: self.view.frame.width, height: self.view.frame.width/2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textFieldHeaderIdentifier, for: indexPath) as! TextFieldHeaderCell
            
            let textField = cell.searchTextField
            textField.delegate = self
            
            return cell
        }
            
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellIdentifier, for: indexPath) as? SearchCollectionViewCell {
                cell.configureCell(story: stories[indexPath.row])
                return cell
            }
            else {
                return SearchCollectionViewCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let url =  URL(string: stories[indexPath.row].webURL!) {
                let webViewController = NYTWebViewController(url: url)
                self.navigationController?.pushViewController(webViewController, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // TODO
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        fetchQueryData(query: self.query, page: 0)
        self.query =  textField.text!
        self.page = 0
        return false
    }
}
