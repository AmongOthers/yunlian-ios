//
//  InvitePersonCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class InvitePersonCell: UICollectionViewCell {
    
    struct UX {
        static let AvatarSize:CGFloat = 30
    }
    
    var avatarView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        avatarView = UIImageView()
        contentView.addSubview(avatarView)
        avatarView.layer.cornerRadius = UX.AvatarSize / 2
        avatarView.clipsToBounds = true
    }
    
    func setupConstraints() {
        avatarView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
            make.width.height.equalTo(UX.AvatarSize)
        }
    }
}
