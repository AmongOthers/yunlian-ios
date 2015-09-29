//
//  SettingsButtonCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 29/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class SettingsButtonCell: UITableViewCell {
    
    struct UX {
        static let SideOffset: CGFloat = 8
        static let TopOffset: CGFloat = 25
        static let ButtonHeight: CGFloat = 39
    }
    
    var lockButton: UIButton!
    var exitButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIConstants.BackgroundGray
        lockButton = UIButton()
        contentView.addSubview(lockButton)
        lockButton.setTitle("远程锁定", forState: UIControlState.Normal)
        lockButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        lockButton.backgroundColor = UIConstants.TintColor
        lockButton.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        lockButton.addTarget(self, action: "lockTapped", forControlEvents: UIControlEvents.TouchUpInside)
        exitButton = UIButton()
        contentView.addSubview(exitButton)
        exitButton.setTitle("退出账号", forState: UIControlState.Normal)
        exitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        exitButton.backgroundColor = UIConstants.TintColorGreen
        exitButton.layer.cornerRadius = LoginViewControllerUX.CornerRadius
        exitButton.addTarget(self, action: "exitTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setupConstraints() {
        lockButton.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(UX.SideOffset)
            make.right.equalTo(contentView).offset(-UX.SideOffset)
            make.top.equalTo(contentView).offset(UX.TopOffset)
            make.height.equalTo(UX.ButtonHeight)
        }
        exitButton.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(UX.SideOffset)
            make.right.equalTo(contentView).offset(-UX.SideOffset)
            make.top.equalTo(lockButton.snp_bottom).offset(UX.TopOffset)
            make.height.equalTo(UX.ButtonHeight)
        }
    }

}
