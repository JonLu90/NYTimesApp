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
        self.backgroundColor = UIColor.blue
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
    }
    
    func setupConstraints() {
    
        thumbnailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0/2.0)
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
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0/4.0)
        }
    }
    
    // MARK: UI Properties
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        return label
    }()
    
    let snippetLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        return label
    }()
}
