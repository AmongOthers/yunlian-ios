//
//  BlackListContactCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/20.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class BlackListContactCell: FriendsContactCell {
    
    struct UX {
        static let ButtonRightOffset = 8
    }
    
    var removeButton: UIButton!
    
    override func setupViews() {
        super.setupViews()
        removeButton = UIButton()
        contentView.addSubview(removeButton)
        removeButton.setTitle("解除", forState: UIControlState.Normal)
        removeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        removeButton.titleLabel?.font = UIConstants.DefaultButtonFont
        removeButton.backgroundColor = UIConstants.TintColor
        removeButton.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        avatarView.image = UIImage(named: "anonymous")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        removeButton.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(UIConstants.DefaultButtonWidth)
            make.height.equalTo(UIConstants.DefaultButtonHeight)
            make.right.equalTo(self.contentView).offset(-UX.ButtonRightOffset)
        }
    }

}
