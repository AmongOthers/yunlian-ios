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
    static let MobileTextFieldTopOffset = 106
    static let LeftViewWidth:CGFloat = 46
    static let TextFieldHeight:CGFloat = 43.5
    static let PasswordTextFieldTopOffset = 9
    static let LoginButtonTopOffset = 24
    static let ActionButtonOffset = 20
    static let LeftOffset = 30
    static let RightOffset = -30
    static let CornerRadius:CGFloat = 3
}

class LoginViewController: UIViewController {
    var mobileTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var takeBackPasswordButton: UIButton!
    var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.userInteractionEnabled = true
        view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "backgroundTapped")]
        view.backgroundColor = UIConstants.BackgroundGray
        // Do any additional setup after loading the view, typically from a nib.
        mobileTextField = UITextField()
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
        view.addSubview(passwordTextField)
        passwordTextField.backgroundColor = UIColor.whiteColor()
        let passwordLeftView = TextFieldLeftView(frame: CGRectMake(0, 0, LoginViewControllerUX.LeftViewWidth, LoginViewControllerUX.TextFieldHeight), image: UIImage(named: "password")!)
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        passwordTextField.leftView = passwordLeftView
        passwordTextField.tintColor = UIConstants.TintColor
        passwordTextField.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        passwordTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        passwordTextField.placeholder = "密码"
        setupConstraints()
    }
    
    func backgroundTapped() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        mobileTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewControllerUX.TextFieldHeight)
            make.left.equalTo(self.view).offset(LoginViewControllerUX.LeftOffset)
            make.right.equalTo(self.view).offset(LoginViewControllerUX.RightOffset)
            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(LoginViewControllerUX.MobileTextFieldTopOffset)
        }
        passwordTextField.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(LoginViewControllerUX.TextFieldHeight)
            make.left.equalTo(self.view).offset(LoginViewControllerUX.LeftOffset)
            make.right.equalTo(self.view).offset(LoginViewControllerUX.RightOffset)
            make.top.equalTo(self.mobileTextField.snp_bottom).offset(LoginViewControllerUX.PasswordTextFieldTopOffset)
        }
    }

}
