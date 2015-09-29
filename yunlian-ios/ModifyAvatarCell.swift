//
//  ModifyAvatarCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 28/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ModifyAvatarCell: ModifyInfoBaseCell {
    
    struct  UX {
        static let AvatarSize: CGFloat = 42.5
        static let RightOffset: CGFloat = 18
    }
    
    var avatar: UIImageView!
    
    override func setupViews() {
        super.setupViews()
        label.text = "头像"
        avatar = UIImageView()
        contentView.addSubview(avatar)
        avatar.image = UIImage(named: "1")
        avatar.layer.cornerRadius = UX.AvatarSize / 2
        avatar.contentMode = UIViewContentMode.ScaleAspectFill
        avatar.clipsToBounds = true
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        avatar.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.AvatarSize)
            make.right.equalTo(contentView).offset(-UX.RightOffset)
            make.centerY.equalTo(contentView)
        }
    }
}
