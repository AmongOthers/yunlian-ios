//
//  ProfileCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/25.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.whiteColor()
    }
    
    func setupConstraints() {
        
    }
}
