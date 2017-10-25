//
//  SearchCollectionViewCell.swift
//  NYTimesProject
//
//  Created by JonLu on 10/24/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


class SearchCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    func setupUI() {
    
        contentView.addSubview(thumbnailView)
        contentView.addSubview(headlineLabel)
        contentView.addSubview(snippetLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(lineView)
    }
    
    func setupConstraints() {
    
        thumbnailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0/2.2)
            make.height.equalTo(thumbnailView.snp.width).multipliedBy(1.0/2.0)
        }
        headlineLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0/2.0)
            make.height.equalTo(headlineLabel.snp.width).multipliedBy(1.0/2.0)
        }
        snippetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headlineLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(contentView.snp.height).multipliedBy(1.0/3.0)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snippetLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0/4.0)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.height.equalTo(2)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    func configureCell(story: SearchStory) {
        headlineLabel.text = story.headline
        snippetLabel.text = story.snippet
        if let date = story.date {
            dateLabel.text = UtilityFunctions.convertDateFormat(date)
        }
        // some video news can be without thumbnail url
        // for those display default nytimes logo
        if let urlString = story.thumbnailURL {
            thumbnailView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "news_placeholder"), options: [.continueInBackground, .progressiveDownload], completed: nil)
        } else {
            thumbnailView.image = UIImage(named: "nytimes_black")
        }
    }
    
    // MARK: UI Properties
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let snippetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.textAlignment = .center
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
}
