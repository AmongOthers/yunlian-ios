//
//  ModifyGenderCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 28/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ModifyGenderCell: ModifyInfoBaseCell {
    
    struct UX {
        static let RadioButtonImageInset: CGFloat = 4
        static let RightOffset: CGFloat = 18
    }
    
    var maleButton: UIButton!
    var femaleButton: UIButton!
    
    override func setupViews() {
        super.setupViews()
        label.text = "性别"
        maleButton = UIButton(type: UIButtonType.Custom)
        contentView.addSubview(maleButton)
        maleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4)
        maleButton.setImage(UIImage(named: "radio_notselected"), forState: UIControlState.Normal)
        maleButton.setImage(UIImage(named: "radio_selected"), forState: UIControlState.Selected)
        maleButton.setTitle("男", forState: UIControlState.Normal)
        maleButton.setTitleColor(UIConstants.FontColorGray, forState: UIControlState.Normal)
        maleButton.titleLabel?.font = UIConstants.DefaultMediumFont
        maleButton.selected = true
        maleButton.addTarget(self, action: "maleSelected", forControlEvents: UIControlEvents.TouchUpInside)
        
        femaleButton = UIButton(type: UIButtonType.Custom)
        contentView.addSubview(femaleButton)
        femaleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4)
        femaleButton.setImage(UIImage(named: "radio_notselected"), forState: UIControlState.Normal)
        femaleButton.setImage(UIImage(named: "radio_selected"), forState: UIControlState.Selected)
        femaleButton.setTitle("女", forState: UIControlState.Normal)
        femaleButton.setTitleColor(UIConstants.FontColorGray, forState: UIControlState.Normal)
        femaleButton.titleLabel?.font = UIConstants.DefaultMediumFont
        femaleButton.selected = false
        femaleButton.addTarget(self, action: "femaleSelected", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        femaleButton.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-UX.RightOffset)
        }
        maleButton.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.right.equalTo(femaleButton.snp_left).offset(-UX.RightOffset)
        }
    }
    
    func maleSelected() {
        maleButton.selected = true
        femaleButton.selected = false
    }
    
    func femaleSelected() {
        femaleButton.selected = true
        maleButton.selected = false
    }
}
