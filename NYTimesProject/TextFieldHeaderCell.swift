//
//  textFieldHeaderCell.swift
//  NYTimesProject
//
//  Created by JonLu on 10/25/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import UIKit


class TextFieldHeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(searchTextField)
        self.contentView.backgroundColor = UIColor.yellow
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.searchTextField.frame = self.contentView.frame
    }
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type a topic here to search..."
        textField.returnKeyType = .done
        return textField
    }()
}
