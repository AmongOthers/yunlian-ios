//
//  RegisterPhoneNumberViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/22.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class RegisterPhoneNumberViewController: UIViewController {
    struct UX {
        static let LeftOffset = 8
        static let RightOffset = -8
        static let TopOffset = 20
        static let CornerRadius:CGFloat = 3
        static let SmsMiddleSpace: CGFloat = 10
        static let GetSmsCodeButtonBackgroudColor = UIColor(rgb: 0xf5f4f4)
        static let TextFieldHeight:CGFloat = 44
        static let TextFieldInsetX: CGFloat = 8
    }
    
    var phoneNumberTextField: UITextField!
    var smsCodeTextField: UITextField!
    var getSmsCodeButton: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "填写手机号码"
        view.backgroundColor = UIConstants.BackgroundGray
        setupViews();
        setupConstraints();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        navigationItem.hidesBackButton = true
        let cancelItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelTapped")
        navigationItem.leftBarButtonItem = cancelItem
        let nextItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Plain, target: self, action: "nextTapped")
        navigationItem.rightBarButtonItem = nextItem
        
        phoneNumberTextField = UITextFieldWithInset(frame: CGRectZero, insetX: UX.TextFieldInsetX, insetY: 0)
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.backgroundColor = UIColor.whiteColor()
        phoneNumberTextField.layer.cornerRadius = UX.CornerRadius
        phoneNumberTextField.tintColor = UIConstants.TintColor
        phoneNumberTextField.keyboardType = UIKeyboardType.PhonePad
        phoneNumberTextField.placeholder = "手机号码"
    }
    
    func setupConstraints() {
        phoneNumberTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.TextFieldHeight)
            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.right.equalTo(view).offset(UX.RightOffset)
        }
    }
    
    func nextTapped() {
        
    }
    
    func cancelTapped() {
        navigationController?.popViewControllerAnimated(false)
    }
}
