//
//  RegisterPasswordViewController.swift
//  yunlian-ios
//
//  Created by zikang zou on 25/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class RegisterPasswordViewController: UIViewController {
    
    struct UX {
        static let LeftOffset = 8
        static let RightOffset = -8
        static let TopOffset = 20
        static let CornerRadius:CGFloat = 3
        static let TextFieldHeight:CGFloat = 44
        static let TextFieldInsetX: CGFloat = 8
        static let MiddleSpace: CGFloat = 17
    }
    
    var registerInfo: RegisterInfo?
    
    var previousItem: UIBarButtonItem!
    var nextItem: UIBarButtonItem!
    var passwordTextField: UITextField!
    var passwordAgainTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "确认密码"
        view.backgroundColor = UIConstants.BackgroundGray
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        navigationItem.hidesBackButton = true
        previousItem = UIBarButtonItem(title: "上一步", style: UIBarButtonItemStyle.Plain, target: self, action: "previousTapped")
        navigationItem.leftBarButtonItem = previousItem
        nextItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Plain, target: self, action: "nextTapped")
        navigationItem.rightBarButtonItem = nextItem
//        nextItem.enabled = false
        
        passwordTextField = UITextFieldWithInsets(frame: CGRectZero, insetX: UX.TextFieldInsetX, insetY: 0)
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        passwordTextField.backgroundColor = UIColor.whiteColor()
        let passwordRightView = UIImageView(frame: CGRectMake(0, 0, LoginViewControllerUX.RightViewWidth, LoginViewControllerUX.TextFieldHeight))
        passwordRightView.image = UIImage(named: "passwordHide")
        passwordRightView.contentMode = UIViewContentMode.Center
        passwordRightView.userInteractionEnabled = true
        passwordRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "passwordRightViewTapped"))
        passwordTextField.rightViewMode = UITextFieldViewMode.Always
        passwordTextField.rightView = passwordRightView
        passwordTextField.tintColor = UIConstants.TintColor
        passwordTextField.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        passwordTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        passwordTextField.secureTextEntry = true
        passwordTextField.placeholder = "密码"
        passwordTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        
        passwordAgainTextField = UITextFieldWithInsets(frame: CGRectZero, insetX: UX.TextFieldInsetX, insetY: 0)
        passwordAgainTextField.delegate = self
        view.addSubview(passwordAgainTextField)
        passwordAgainTextField.backgroundColor = UIColor.whiteColor()
        let passwordAgainRightView = UIImageView(frame: CGRectMake(0, 0, LoginViewControllerUX.RightViewWidth, LoginViewControllerUX.TextFieldHeight))
        passwordAgainRightView.image = UIImage(named: "passwordHide")
        passwordAgainRightView.contentMode = UIViewContentMode.Center
        passwordAgainRightView.userInteractionEnabled = true
        passwordAgainRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "passwordRightViewTapped"))
        passwordAgainTextField.rightViewMode = UITextFieldViewMode.Always
        passwordAgainTextField.rightView = passwordAgainRightView
        passwordAgainTextField.tintColor = UIConstants.TintColor
        passwordAgainTextField.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        passwordAgainTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        passwordAgainTextField.secureTextEntry = true
        passwordAgainTextField.placeholder = "确认密码"
        passwordAgainTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
    }
    
    func setupConstraints() {
        passwordTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.TextFieldHeight)
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.right.equalTo(view).offset(UX.RightOffset)
        }
        passwordAgainTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.TextFieldHeight)
            make.top.equalTo(passwordTextField.snp_bottom).offset(UX.MiddleSpace)
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.right.equalTo(view).offset(UX.RightOffset)
        }
    }
    
    func passwordRightViewTapped() {
        passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
        if(passwordTextField.secureTextEntry) {
            (passwordTextField.rightView as! UIImageView).image = UIImage(named: "passwordHide")
        } else {
            (passwordTextField.rightView as! UIImageView).image = UIImage(named: "passwordDisplay")
        }
        passwordAgainTextField.secureTextEntry = !passwordAgainTextField.secureTextEntry
        if(passwordAgainTextField.secureTextEntry) {
            (passwordAgainTextField.rightView as! UIImageView).image = UIImage(named: "passwordHide")
        } else {
            (passwordAgainTextField.rightView as! UIImageView).image = UIImage(named: "passwordDisplay")
        }
    }
    
    func previousTapped() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func nextTapped() {
        if false && passwordTextField.text != passwordAgainTextField.text {
            showSimpleMessage("", message: "两次输入的密码不一致")
        } else {
            registerInfo?.password = passwordTextField.text
            var parameters = [String: AnyObject]()
            parameters["isFull"] = true
            yunlianRequest(.GetQuestion, parameters: parameters, whenSuccessful: { (json) -> Void in
                let controller = RegisterQuestionViewController()
                var questions = [Int: String]()
                let questionsJSON = json["result"]["questions"].arrayValue
                questionsJSON.forEach() { j -> Void in
                    let i = j["id"].intValue
                    questions[i] = j["description"].stringValue
                }
                controller.questions = questions
                controller.registerInfo = self.registerInfo
                self.navigationController?.pushViewController(controller, animated: true)
            })
        }
    }
}

extension RegisterPasswordViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "" && range.length == textField.text?.characters.count {
            nextItem.enabled = false
        } else {
            if textField == passwordTextField && passwordAgainTextField.text != "" {
                nextItem.enabled = true
            } else if textField == passwordAgainTextField && passwordTextField.text != "" {
                nextItem.enabled = true
            }
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
