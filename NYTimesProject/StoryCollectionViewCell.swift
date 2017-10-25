//
//  StoryCollectionViewCell.swift
//  NYTimesProject
//
//  Created by JonLu on 10/23/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


class StoryCollectionViewCell: UICollectionViewCell {
    
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
    
    func configureCellData(_ story: Story) {
        
        self.sectionLabel.text = story.section
        self.subSectionLabel.text = story.subsection
        self.titleLabel.text = story.title
        self.dateLabel.text = UtilityFunctions.convertDateFormat(story.publishedDate!)
        
        if let imageURL: String = story.thumbnailURL {
            self.thumbnailImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "news_placeholder"), options: [.continueInBackground, .progressiveDownload], completed: nil)
        } else {
            self.thumbnailImageView.image = UIImage(named: "nytimes_black")
        }
    }
    
    func setupUI() {
        
        contentView.addSubview(sectionLabel)
        contentView.addSubview(subSectionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(lineView)
    }
    
    func setupConstraints() {
        
        sectionLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(4)
            make.height.equalToSuperview().multipliedBy(1.0/6.0)
            make.width.equalToSuperview().multipliedBy(1.0/5.0)
        }
        subSectionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(sectionLabel.snp.right).offset(4)
            make.height.equalToSuperview().multipliedBy(1.0/6.0)
            make.width.equalToSuperview().multipliedBy(1.0/6.0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subSectionLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(4)
            make.width.equalToSuperview().multipliedBy(1.0/2.0)
            make.height.equalTo(self.contentView.snp.height).multipliedBy(2.0/3.5)
        }
        thumbnailImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-4)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(2.0/5.0)
            make.height.equalTo(thumbnailImageView.snp.width)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(1.0/8.0)
            make.height.equalTo(self.contentView.snp.height).multipliedBy(1.0/15.0)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(2)
        }
    }
    
    // MARK: UI Properties
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subSectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
}
