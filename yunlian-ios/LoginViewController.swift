//
//  LoginViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

struct LoginViewControllerUX {
    static let LogoWidth:CGFloat = 66.5
    static let LogoHeight = 65
    static let LogoTopOffset = 20
    static let LogoBottomOffset = 20
    static let LeftViewWidth:CGFloat = 46
    static let RightViewWidth:CGFloat = 44
    static let TextFieldHeight:CGFloat = 44
    static let PasswordTextFieldTopOffset = 9
    static let LoginButtonTopOffset = 24
    static let ActionButtonOffset = 20 - 10 //考虑Button的Padding
    static let LeftOffset = 30
    static let RightOffset = -30
    static let CornerRadius:CGFloat = 3
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    var top: UIView!
    var logo: UIImageView!
    var mobileTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var takeBackPasswordButton: UIButton!
    var registerButton: UIButton!
    var isTextFieldEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.userInteractionEnabled = true
        view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "backgroundTapped:")]
        view.backgroundColor = UIConstants.BackgroundGray
        // Do any additional setup after loading the view, typically from a nib.
        top = UIView()
        view.addSubview(top)
        logo = UIImageView(image: UIImage(named: "loginlogo"))
        view.addSubview(logo)
        mobileTextField = UITextField()
        mobileTextField.delegate = self
        view.addSubview(mobileTextField)
        mobileTextField.backgroundColor = UIColor.whiteColor()
        let mobileLeftView = TextFieldLeftView(frame: CGRectMake(0, 0, LoginViewControllerUX.LeftViewWidth, LoginViewControllerUX.TextFieldHeight), image: UIImage(named: "phonenumber")!)
        mobileTextField.leftViewMode = UITextFieldViewMode.Always
        mobileTextField.leftView = mobileLeftView
        mobileTextField.tintColor = UIConstants.TintColor
        mobileTextField.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        mobileTextField.keyboardType = UIKeyboardType.PhonePad
        mobileTextField.placeholder = "手机号码"
        passwordTextField = UITextField()
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        passwordTextField.backgroundColor = UIColor.whiteColor()
        let passwordLeftView = TextFieldLeftView(frame: CGRectMake(0, 0, LoginViewControllerUX.LeftViewWidth, LoginViewControllerUX.TextFieldHeight), image: UIImage(named: "password")!)
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        passwordTextField.leftView = passwordLeftView
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
        loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.setTitle("登录", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginButton.backgroundColor = UIConstants.TintColor
        loginButton.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        loginButton.addTarget(self, action: "loginTapped", forControlEvents: UIControlEvents.TouchUpInside)
        takeBackPasswordButton = UIButton()
        view.addSubview(takeBackPasswordButton)
        takeBackPasswordButton.setTitle("找回密码", forState: UIControlState.Normal)
        takeBackPasswordButton.setTitleColor(UIConstants.FirstGray, forState: UIControlState.Normal)
        takeBackPasswordButton.titleLabel?.font = UIConstants.DefaultMediumFont
        takeBackPasswordButton.addTarget(self, action: "takeBackPasswordTapped", forControlEvents: UIControlEvents.TouchUpInside)
        registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.setTitle("注册", forState: UIControlState.Normal)
        registerButton.setTitleColor(UIConstants.TintColor, forState: UIControlState.Normal)
        registerButton.titleLabel?.font = UIConstants.DefaultMediumFont
        registerButton.addTarget(self, action: "registerTapped", forControlEvents: UIControlEvents.TouchUpInside)
        setupConstraints()
    }
    
    func backgroundTapped(recognizer: UIGestureRecognizer) {
        view.endEditing(true)
        let takeBackPasswordButtonPoint = takeBackPasswordButton.center
        let registerButtonPoint = registerButton.center
        let touchPoint = recognizer.locationInView(view)
        let touchPointTuple = (touchPoint.x, touchPoint.y)
        switch touchPointTuple {
        case let(x, y) where abs(x - takeBackPasswordButtonPoint.x) <= UIConstants.TouchAreaDistance && abs(y - takeBackPasswordButtonPoint.y) <= UIConstants.TouchAreaDistance:
            takeBackPasswordTapped()
            break;
        case let(x, y) where abs(x - registerButtonPoint.x) <= UIConstants.TouchAreaDistance && abs(y - registerButtonPoint.y) <= UIConstants.TouchAreaDistance:
            registerTapped()
            break;
        default:
            break;
        }
    }
    
    func loginTapped() {
        let alert = UIAlertController(title: "未连接到互联网", message: "请检查网络配置", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "好", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func passwordRightViewTapped() {
        passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
        if(passwordTextField.secureTextEntry) {
            (passwordTextField.rightView as! UIImageView).image = UIImage(named: "passwordHide")
        } else {
            (passwordTextField.rightView as! UIImageView).image = UIImage(named: "passwordDisplay")
        }
    }
    
    func takeBackPasswordTapped() {
        
    }
    
    func registerTapped() {
        navigationController?.pushViewController(RegisterPhoneNumberViewController(), animated: false)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        isTextFieldEditing = true
        view.setNeedsUpdateConstraints()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        isTextFieldEditing = false
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        setupConstraints()
        super.updateViewConstraints()
    }
    
    func setupConstraints() {
        if(!isTextFieldEditing) {
            top.snp_remakeConstraints { (make) -> Void in
                make.top.equalTo(self.snp_topLayoutGuideBottom)
                make.width.height.equalTo(1)
                make.centerX.equalTo(self.view)
            }
        } else {
            top.snp_remakeConstraints { (make) -> Void in
                make.top.equalTo(self.snp_topLayoutGuideBottom).offset(-LoginViewControllerUX.LogoTopOffset - LoginViewControllerUX.LogoHeight)
                make.width.height.equalTo(1)
                make.centerX.equalTo(self.view)
            }
        }
        logo.snp_remakeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.width.equalTo(LoginViewControllerUX.LogoWidth)
            make.height.equalTo(LoginViewControllerUX.LogoHeight)
            make.top.equalTo(self.top).offset(LoginViewControllerUX.LogoTopOffset)
        }
        mobileTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewControllerUX.TextFieldHeight)
            make.left.equalTo(self.view).offset(LoginViewControllerUX.LeftOffset)
            make.right.equalTo(self.view).offset(LoginViewControllerUX.RightOffset)
            make.top.equalTo(self.logo.snp_bottom).offset(LoginViewControllerUX.LogoBottomOffset)
        }
        passwordTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewControllerUX.TextFieldHeight)
            make.left.equalTo(self.view).offset(LoginViewControllerUX.LeftOffset)
            make.right.equalTo(self.view).offset(LoginViewControllerUX.RightOffset)
            make.top.equalTo(self.mobileTextField.snp_bottom).offset(LoginViewControllerUX.PasswordTextFieldTopOffset)
        }
        loginButton.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewControllerUX.TextFieldHeight)
            make.left.equalTo(self.view).offset(LoginViewControllerUX.LeftOffset)
            make.right.equalTo(self.view).offset(LoginViewControllerUX.RightOffset)
            make.top.equalTo(self.passwordTextField.snp_bottom).offset(LoginViewControllerUX.LoginButtonTopOffset)
        }
        takeBackPasswordButton.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(loginButton.snp_bottom).offset(LoginViewControllerUX.ActionButtonOffset)
            make.left.equalTo(loginButton)
        }
        registerButton.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(loginButton.snp_bottom).offset(LoginViewControllerUX.ActionButtonOffset)
            make.right.equalTo(loginButton)
        }
    }

}
