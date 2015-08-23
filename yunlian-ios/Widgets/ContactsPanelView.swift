//
//  ContactsPanelView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/22.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class ContactsPanelView: UIView {
    struct UX {
    }
    
    var sweepButton: UIButton!
    var addFriendButtton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        sweepButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        addSubview(sweepButton)
        sweepButton.setImage(UIImage(named: "sweep"), forState: UIControlState.Normal)
        sweepButton.setTitle("扫一扫", forState: UIControlState.Normal)
        sweepButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sweepButton.setBackgroundImage(UIImage(fillColor: UIConstants.BackgroundColor), forState: UIControlState.Normal)
        sweepButton.setBackgroundImage(UIImage(fillColor: UIConstants.SelectedBackgroundColor), forState: UIControlState.Selected)
        sweepButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 11)
        sweepButton.titleLabel?.font = UIConstants.DefaultMediumFont
        
        addFriendButtton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        addSubview(addFriendButtton)
        addFriendButtton.setImage(UIImage(named: "addFriend"), forState: UIControlState.Normal)
        addFriendButtton.setTitle("添加朋友", forState: UIControlState.Normal)
        addFriendButtton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addFriendButtton.setBackgroundImage(UIImage(fillColor: UIConstants.BackgroundColor), forState: UIControlState.Normal)
        addFriendButtton.setBackgroundImage(UIImage(fillColor: UIConstants.SelectedBackgroundColor), forState: UIControlState.Selected)
        addFriendButtton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 11)
        addFriendButtton.titleLabel?.font = UIConstants.DefaultMediumFont
    }
    
    func setupConstraints() {
        sweepButton.snp_remakeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
        addFriendButtton.snp_remakeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
    }

}
