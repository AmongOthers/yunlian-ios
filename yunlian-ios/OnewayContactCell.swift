//
//  OnewayContactCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/19.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class OnewayContactCell: FriendsContactCell {
    
    struct UX {
        static let ButtonRightOffset = 8
    }
    
    var addButton: UIButton!
    
    override func setupViews() {
        super.setupViews()
        addButton = UIButton()
        contentView.addSubview(addButton)
        addButton.setTitle("添加", forState: UIControlState.Normal)
        addButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addButton.titleLabel?.font = UIConstants.DefaultButtonFont
        addButton.backgroundColor = UIConstants.TintColorGreen
        addButton.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        addButton.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(UIConstants.DefaultButtonWidth)
            make.height.equalTo(UIConstants.DefaultButtonHeight)
            make.right.equalTo(self.contentView).offset(-UX.ButtonRightOffset)
        }
    }
}
