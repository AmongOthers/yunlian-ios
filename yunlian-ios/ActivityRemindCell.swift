//
//  ActivityNotifyCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ActivityRemindCell: ActivityBaseCell {
    
    var textField: UITextField!
    
    override func setupViews() {
        super.setupViews()
        textField = UITextField()
        contentView.addSubview(textField)
        textField.placeholder = "请选择"
        textField.font = UIConstants.DefaultMediumFont
        textField.textColor = UIConstants.FontColorGray
        textField.textAlignment = NSTextAlignment.Right
        let rightView = UIImageView(frame: CGRectMake(0, 0, UX.ImageSize, UX.ImageSize))
        rightView.image = UIImage(named: "remind")
        rightView.contentMode = UIViewContentMode.ScaleAspectFit
        rightView.userInteractionEnabled = true
        rightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "remindTapped"))
        textField.rightViewMode = UITextFieldViewMode.Always
        textField.rightView = rightView
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        super.setupConstraints()
        textField.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-UX.RightOffset / 2)
            make.left.equalTo(label.snp_right).offset(UX.TextOffset)
            make.centerY.equalTo(contentView)
            make.height.equalTo(UX.TextHeight)
        }
    }
}
