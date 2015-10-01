//
//  ActivityTextCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ActivityTextCell: ActivityBaseCell {
    
    var textField: UITextField!
    
    override func setupViews() {
        super.setupViews()
        textField = UITextField()
        contentView.addSubview(textField)
        textField.delegate = self
        textField.placeholder = "请输入"
        textField.font = UIConstants.DefaultMediumFont
        textField.textColor = UIConstants.FontColorGray
        textField.textAlignment = NSTextAlignment.Right
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        textField.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-UX.RightOffset)
            make.left.equalTo(label.snp_right).offset(UX.TextOffset)
            make.centerY.equalTo(contentView)
        }
    }
}

extension ActivityTextCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.textAlignment = NSTextAlignment.Left
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.textAlignment = NSTextAlignment.Right
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
