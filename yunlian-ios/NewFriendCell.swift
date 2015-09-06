//
//  NewFriendCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/6.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class NewFriendCell: FriendsContactCell {
    
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
//        let recognizer = UISwipeGestureRecognizer(target: self, action: "swipped")
//        recognizer.direction = .Left
//        contentView.addGestureRecognizer(recognizer)
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
    
    func swipped() {
        addButton.setTitle("删除", forState: UIControlState.Normal)
    }

}
