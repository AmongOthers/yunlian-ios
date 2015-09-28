//
//  ModifyTextCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 28/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ModifyTextCell: ModifyInfoBaseCell {
    
    struct  UX {
        static let RightOffset: CGFloat = 18
        static let TextOffset: CGFloat = 10
    }
    
    var textField: UITextField!
    
    override func setupViews() {
        super.setupViews()
        label.text = "公司"
        label.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        textField = UITextField()
        contentView.addSubview(textField)
        textField.font = UIConstants.DefaultMediumFont
        textField.textColor = UIConstants.FontColorGray
        textField.textAlignment = NSTextAlignment.Right
        textField.delegate = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        textField.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(label.snp_right).offset(UX.TextOffset)
            make.right.equalTo(contentView).offset(-UX.RightOffset)
        }
    }

}

extension ModifyTextCell: UITextFieldDelegate {
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
