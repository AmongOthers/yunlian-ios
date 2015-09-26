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
        static let LabelWidth: CGFloat = 38
        static let TopOffset: CGFloat = 20
        static let LeftOffset = 8
        static let RightOffset = -8
        static let TipHeight: CGFloat = 50
        static let MiddleSpace: CGFloat = 10
        static let CornerRadius: CGFloat = 3
        static let ActionLabelHeight: CGFloat = 40
        static let ItemInset: CGFloat = 17.5
        static let TextField0Offset: CGFloat = TopOffset + TipHeight
        static let TextField1Offset: CGFloat = TopOffset + TipHeight + ItemInset * 2 + ActionLabelHeight * 2
        static let TextField2Offset: CGFloat = TextField1Offset + ItemInset * 2 + ActionLabelHeight * 2
    }
    
    var registerInfo: RegisterInfo?
    
    var tipLabel: UILabel!
    var questionLabels: [UILabel]!
    var questionActionLabels: [UILabel]!
    var answerLabels: [UILabel]!
    var answerTextFields: [UITextField]!
    var viewOriginFrame: CGRect!
    
    var questions = [0: "你的第一个女朋友的名字", 1: "你的第一个上司的名字", 2: "你的第一条狗的名字", 3: "你的第一个老板的名字"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择安全问题"
        view.backgroundColor = UIConstants.BackgroundGray
        view.userInteractionEnabled = true
        view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "backgroundTapped:")]
        viewOriginFrame = view.frame
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
        
        questionLabels = [UILabel]()
        questionActionLabels = [UILabel]()
        answerLabels = [UILabel]()
        answerTextFields = [UITextField]()
        for i in 0...2 {
            let questionActionLabel = UILabelWithInsets(frame: CGRectZero, insets: UIEdgeInsetsMake(0, 5, 0, 5))
            questionActionLabels.append(questionActionLabel)
            view.addSubview(questionActionLabel)
            questionActionLabel.text = "请选择"
            questionActionLabel.textColor = UIConstants.TintColor
            questionActionLabel.font = UIConstants.DefaultMediumFont
            questionActionLabel.backgroundColor = UIColor.whiteColor()
            questionActionLabel.layer.cornerRadius = UX.CornerRadius
            questionActionLabel.clipsToBounds = true
            questionActionLabel.userInteractionEnabled = true
            questionActionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("chooseQuestion\(i)")))
            questionActionLabel.tag = -1
        
            let questionLabel = UILabel()
            view.addSubview(questionLabel)
            questionLabels.append(questionLabel)
            questionLabel.font = UIConstants.DefaultMediumFont
            questionLabel.textColor = UIConstants.FontColorGray
            questionLabel.text = "问题\(i + 1)"
            
            let answerLabel = UILabel()
            view.addSubview(answerLabel)
            answerLabels.append(answerLabel)
            answerLabel.font = UIConstants.DefaultMediumFont
            answerLabel.textColor = UIConstants.FontColorGray
            answerLabel.text = "答案"
            
            let answerTextField = UITextFieldWithInsets(frame: CGRectZero, insetX: 5, insetY: 0)
            view.addSubview(answerTextField)
            answerTextField.delegate = self
            answerTextFields.append(answerTextField)
            answerTextField.font = UIConstants.DefaultMediumFont
            answerTextField.textColor = UIConstants.FontColorGray
            answerTextField.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func setupConstraints() {
        tipLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.height.equalTo(UX.TipHeight)
            make.left.equalTo(view).offset(UX.LeftOffset)
            make.right.equalTo(view).offset(UX.RightOffset)
        }
        for i in 0...2 {
            let questionActionLabel = questionActionLabels[i]
            let questionLabel = questionLabels[i]
            let answerTextField = answerTextFields[i]
            let answerLabel = answerLabels[i]
            questionActionLabel.snp_remakeConstraints { (make) -> Void in
                if (i == 0) {
                    make.top.equalTo(tipLabel.snp_bottom).offset(UX.ItemInset)
                } else {
                    make.top.equalTo(answerTextFields[i - 1].snp_bottom).offset(UX.ItemInset)
                }
                make.right.equalTo(view).offset(UX.RightOffset)
                make.left.equalTo(questionLabel.snp_right).offset(UX.MiddleSpace)
                make.height.equalTo(UX.ActionLabelHeight)
            }
            questionLabel.snp_remakeConstraints { (make) -> Void in
                make.left.equalTo(view).offset(UX.LeftOffset)
                make.width.equalTo(UX.LabelWidth)
                make.centerY.equalTo(questionActionLabel)
            }
            answerTextField.snp_remakeConstraints { (make) -> Void in
                make.top.equalTo(questionActionLabel.snp_bottom).offset(UX.ItemInset)
                make.height.right.equalTo(questionActionLabel)
                make.left.equalTo(answerLabel.snp_right).offset(UX.MiddleSpace)
            }
            answerLabel.snp_remakeConstraints { (make) -> Void in
                make.left.right.equalTo(questionLabel)
                make.centerY.equalTo(answerTextField)
            }    
        }
        
    }
    
    func previousTapped() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func nextTapped() {
        var parameters = [String: AnyObject]()
                parameters["userId"] = 2
                var ids = [Int]()
                self.questionActionLabels.forEach({ (label) -> () in
                    ids.append(label.tag)
                })
                parameters["questionIds"] = ids
                var answers = [String]()
                self.answerTextFields.forEach({ (text) -> () in
                    answers.append(text.text!)
                })
                parameters["answers"] = answers
                self.yunlianRequest(Api.AnswerQuestion, parameters: parameters, whenSuccessful: { (json) -> Void in
                    print(json)
                })
//        var parameters = [String: AnyObject]()
//        parameters["phoneNumber"] = registerInfo?.phoneNumber
//        parameters["password"] = registerInfo?.password
//        yunlianRequest(.Register, parameters: parameters) { (json) -> Void in
//            print(json)
//            NSUserDefaults.standardUserDefaults().setObject("2", forKey: "userId")
//            if let userId = NSUserDefaults.standardUserDefaults().stringForKey("userId") {
//                
//            }
//        }
    }
    
    func backgroundTapped(_: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func chooseQuestion0() {
        showQuestions(questionActionLabels[0])
    }
    
    func chooseQuestion1() {
        showQuestions(questionActionLabels[1])
    }
    
    func chooseQuestion2() {
        showQuestions(questionActionLabels[2])
    }
    
    func showQuestions(label: UILabel) {
        let alert = UIAlertController(title: "选择问题", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        questions.forEach { (key, value) -> () in
            let action = UIAlertAction(title: value, style: UIAlertActionStyle.Default, handler: {
                _ -> Void in
                if label.tag >= 0 {
                    self.questions[label.tag] = label.text
                }
                label.tag = key
                label.text = value
                self.questions.removeValueForKey(label.tag)
            })
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension RegisterQuestionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField != answerTextFields[0] {
            view.frame = CGRectOffset(viewOriginFrame, 0, -UX.TextField1Offset)
        } else {
            view.frame = CGRectOffset(viewOriginFrame, 0, -UX.TextField0Offset)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        view.frame = viewOriginFrame
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
