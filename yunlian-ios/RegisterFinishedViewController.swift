//
//  RegisterFinishedViewController.swift
//  yunlian-ios
//
//  Created by zikang zou on 27/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class RegisterFinishedViewController: UIViewController {
    
    struct UX {
        static let LabelWidth: CGFloat = 38
        static let TopOffset: CGFloat = 20
        static let BottomOffset: CGFloat = 20
        static let LeftOffset: CGFloat = 8
        static let RightOffset: CGFloat = -8
        static let TipHeight: CGFloat = 50
    }
    
    var tipLabel: UILabel!
    var questionTipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "完成"
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        tipLabel = UILabel()
        view.addSubview(tipLabel)
        view.backgroundColor = UIConstants.BackgroundGray
        navigationItem.hidesBackButton = true
        
        tipLabel.font = UIConstants.DefaultMediumFont
        tipLabel.textColor = UIConstants.FontColorGray
        tipLabel.numberOfLines = 2
        let str = NSMutableAttributedString(string: "注册成功！你现在可以登录使用云联名片，给你的工作生活带来更多便捷的体验。")
        str.addAttribute(NSForegroundColorAttributeName, value: UIConstants.TintColor, range: NSMakeRange(10, 2))
        str.addAttribute(NSFontAttributeName, value: UIConstants.DefaultStandardFont, range: NSMakeRange(10, 2))
        str.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(10, 2))
        tipLabel.attributedText = str
        tipLabel.userInteractionEnabled = true
        tipLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "loginTapped"))
        
        questionTipLabel = UILabel()
        view.addSubview(questionTipLabel)
        questionTipLabel.font = UIConstants.DefaultMediumFont
        questionTipLabel.textColor = UIConstants.FontColorGray
        questionTipLabel.numberOfLines = 2
        let questionStr = NSMutableAttributedString(string: "建议你立即设置安全问题，以便我们对你的账号提供更安全的保障。")
        questionStr.addAttribute(NSForegroundColorAttributeName, value: UIConstants.TintColor, range: NSMakeRange(5, 6))
        questionStr.addAttribute(NSFontAttributeName, value: UIConstants.DefaultStandardFont, range: NSMakeRange(5, 6))
        questionStr.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(5, 6))
        questionTipLabel.attributedText = questionStr
        questionTipLabel.userInteractionEnabled = true
        questionTipLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "questionTapped"))
    }
    
    func setupConstraints() {
        tipLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.height.equalTo(UX.TipHeight)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.size.width - 2 * UX.LeftOffset)
        }
        questionTipLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(tipLabel.snp_bottom).offset(UX.TopOffset)
            make.height.equalTo(UX.TipHeight)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.size.width - 2 * UX.LeftOffset)
        }
    }
    
    func loginTapped() {
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
    func questionTapped() {
        navigationController?.pushViewController(RegisterQuestionViewController(), animated: true)
    }
}
