//
//  RegisterQuestionViewController.swift
//  yunlian-ios
//
//  Created by zikang zou on 25/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class RegisterQuestionViewController: UIViewController {
    
    struct UX {
        static let TopOffset: CGFloat = 20
        static let LeftOffset = 8
        static let RightOffset = -8
        static let TipHeight: CGFloat = 50
        static let MiddleSpace: CGFloat = 10
        static let CornerRadius: CGFloat = 2
        static let ActionLabelHeight: CGFloat = 40
    }
    
    var tipLabel: UILabel!
    var question1Label: UILabel!
    var question1ActionLabel: UILabel!
    var answer1Label: UILabel!
    var answer1TextField: UITextField!
    
    var questions = [0: "你的第一个女朋友的名字", 1: "你的第一个上司的名字", 2: "你的第一条狗的名字", 3: "你的第一个老板的名字"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择安全问题"
        view.backgroundColor = UIConstants.BackgroundGray
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        navigationItem.hidesBackButton = true
        let previousItem = UIBarButtonItem(title: "上一步", style: UIBarButtonItemStyle.Plain, target: self, action: "previousTapped")
        navigationItem.leftBarButtonItem = previousItem
        let nextItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Plain, target: self, action: "nextTapped")
        navigationItem.rightBarButtonItem = nextItem
        
        tipLabel = UILabel()
        view.addSubview(tipLabel)
        tipLabel.font = UIConstants.DefaultMediumFont
        tipLabel.textColor = UIConstants.FontColorGray
        tipLabel.numberOfLines = 2
        tipLabel.textAlignment = NSTextAlignment.Center
        tipLabel.text = "在下面选择三个安全提示问题。当您忘记密码时，这些问题可以帮助我们确认您的身份。"
        
        question1ActionLabel = UILabelWithInsets(frame: CGRectZero, insets: UIEdgeInsetsMake(0, 5, 0, 5))
        view.addSubview(question1ActionLabel)
        question1ActionLabel.text = "请选择"
        question1ActionLabel.textColor = UIConstants.TintColor
        question1ActionLabel.font = UIConstants.DefaultMediumFont
        question1ActionLabel.backgroundColor = UIColor.whiteColor()
        question1ActionLabel.layer.cornerRadius = UX.CornerRadius
        
        question1Label = UILabel()
        view.addSubview(question1Label)
        question1Label.font = UIConstants.DefaultMediumFont
        question1Label.textColor = UIConstants.FontColorGray
        question1Label.text = "问题1"
    }
    
    func setupConstraints() {
        tipLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.height.equalTo(UX.TipHeight)
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.right.equalTo(view).offset(UX.RightOffset)
        }
        question1ActionLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(tipLabel.snp_bottom).offset(UX.MiddleSpace)
            make.right.equalTo(view).offset(UX.RightOffset)
            make.left.equalTo(question1Label.snp_right).offset(UX.MiddleSpace)
            make.height.equalTo(UX.ActionLabelHeight)
        }
        question1Label.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.centerY.equalTo(question1ActionLabel)
        }
    }
    
    func showQuestions() {
        let alert = UIAlertController(title: "选择问题", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        questions.forEach { (key, value) -> () in
            let action = UIAlertAction(title: value, style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
}
