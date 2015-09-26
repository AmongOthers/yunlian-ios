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
        static let GetSmsCodeButtonWidth: CGFloat = 90
        static let TextFieldHeight:CGFloat = 44
        static let TextFieldInsetX: CGFloat = 8
        static let MiddleSpace: CGFloat = 17
    }
    
    var phoneNumberTextField: UITextField!
    var smsCodeTextField: UITextField!
    var getSmsCodeButton: UIButton!
    var seconds: Int = 60
    var timer: NSTimer?

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
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let _ = self.timer {
            getSmsCodeButton.setTitle("获取验证码", forState: UIControlState.Normal)
            getSmsCodeButton.enabled = true
        }
    }
    
    func setupViews() {
        navigationItem.hidesBackButton = true
        let cancelItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelTapped")
        navigationItem.leftBarButtonItem = cancelItem
        let nextItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Plain, target: self, action: "nextTapped")
        navigationItem.rightBarButtonItem = nextItem
        
        phoneNumberTextField = UITextFieldWithInsets(frame: CGRectZero, insetX: UX.TextFieldInsetX, insetY: 0)
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.backgroundColor = UIColor.whiteColor()
        phoneNumberTextField.layer.cornerRadius = UX.CornerRadius
        phoneNumberTextField.tintColor = UIConstants.TintColor
        phoneNumberTextField.keyboardType = UIKeyboardType.PhonePad
        phoneNumberTextField.placeholder = "手机号码"
        
        smsCodeTextField = UITextFieldWithInsets(frame: CGRectZero, insetX: UX.TextFieldInsetX, insetY: 0)
        view.addSubview(smsCodeTextField)
        smsCodeTextField.backgroundColor = UIColor.whiteColor()
        smsCodeTextField.layer.cornerRadius = UX.CornerRadius
        smsCodeTextField.tintColor = UIConstants.TintColor
        smsCodeTextField.keyboardType = UIKeyboardType.NumberPad
        smsCodeTextField.placeholder = "短信验证码"
        
        getSmsCodeButton = UIButton()
        view.addSubview(getSmsCodeButton)
        getSmsCodeButton.addTarget(self, action: "getSmsCodeTapped", forControlEvents: UIControlEvents.TouchUpInside)
        getSmsCodeButton.titleLabel?.font = UIConstants.DefaultMediumFont
        getSmsCodeButton.backgroundColor = UX.GetSmsCodeButtonBackgroudColor
        getSmsCodeButton.layer.cornerRadius = UX.CornerRadius
        getSmsCodeButton.titleLabel?.textColor = UIConstants.FirstGray
        getSmsCodeButton.setTitle("获取验证码", forState: UIControlState.Normal)
        getSmsCodeButton.setTitleColor(UIConstants.FontColorGray, forState: UIControlState.Normal)
    }
    
    func setupConstraints() {
        phoneNumberTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.TextFieldHeight)
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.right.equalTo(view).offset(UX.RightOffset)
        }
        getSmsCodeButton.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.TextFieldHeight)
            make.top.equalTo(phoneNumberTextField.snp_bottom).offset(UX.MiddleSpace)
            make.right.equalTo(phoneNumberTextField)
            make.width.equalTo(UX.GetSmsCodeButtonWidth)
        }
        smsCodeTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.TextFieldHeight)
            make.top.equalTo(phoneNumberTextField.snp_bottom).offset(UX.MiddleSpace)
            make.left.equalTo(phoneNumberTextField)
            make.right.equalTo(getSmsCodeButton.snp_left).offset(-UX.SmsMiddleSpace)
        }
    }
    
    func getSmsCodeTapped() {
        getSmsCodeButton.enabled = false
        seconds = 60
        timer = NSTimer(timeInterval: 1, target: self, selector: "ticktack:", userInfo: seconds, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
//        if phoneNumberTextField.text!.isTelNumber() {
//            let timer = NSTimer(timeInterval: 1, target: self, selector: "ticktack", userInfo: 60, repeats: true)
//            timer.fire()
//        } else {
//            showSimpleMessage("", message: "手机号码格式不对")
//        }
    }
    
    func ticktack(timer: NSTimer) {
        seconds--
        getSmsCodeButton.setTitle("\(seconds)秒", forState: UIControlState.Normal)
    }
    
    func nextTapped() {
        navigationController?.pushViewController(RegisterPasswordViewController(), animated: true)
    }
    
    func cancelTapped() {
        navigationController?.popViewControllerAnimated(false)
    }
}
