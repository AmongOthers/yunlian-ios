//
//  TitleSearchView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/23.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

@objc
protocol TitleSearchViewDelegate {
    func cancelTapped()
}

class TitleSearchView: UIView {
    struct UX {
        static let LeftViewWidth:CGFloat = 40
        static let LeftViewHeight:CGFloat = 34
        static let CornerRadius:CGFloat = 3
        static let Offset = 16
    }
    
    var textField: UITextField!
    var cancelButton: UIButton!
    weak var delegate: TitleSearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        textField = UITextField()
        addSubview(textField)
        textField.leftView = TextFieldLeftView(frame: CGRectMake(0, 0, UX.LeftViewWidth, UX.LeftViewHeight), image: UIImage(named: "searchItem")!)
        textField.leftViewMode = UITextFieldViewMode.Always
        textField.placeholder = "搜索"
        textField.layer.cornerRadius = UX.CornerRadius
        textField.backgroundColor = UIColor.whiteColor()
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        textField.tintColor = UIConstants.TintColor
        textField.keyboardType = UIKeyboardType.WebSearch
        
        cancelButton = UIButton()
        addSubview(cancelButton)
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "cancelTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func cancelTapped() {
        delegate?.cancelTapped()
    }
    
    func setupConstraints() {
        cancelButton.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self)
            make.width.equalTo(50)
            make.top.bottom.equalTo(self)
        }
        textField.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self.cancelButton.snp_left)
            make.top.bottom.equalTo(self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
