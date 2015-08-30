//
//  PersonCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/30.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class PersonCell: UICollectionViewCell {
    
    struct UX {
        static let AvatarSize:CGFloat = 42.5
        static let NameFont = UIFont.systemFontOfSize(10)
        static let NameOffset:CGFloat = 4
    }
    
    var avatarView: UIImageView!
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        avatarView = UIImageView()
        contentView.addSubview(avatarView)
        avatarView.layer.cornerRadius = UX.AvatarSize / 2
        avatarView.clipsToBounds = true
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UX.NameFont
        titleLabel.textColor = UIConstants.FontColorSecondGray
    }
    
    func setupConstraints() {
        avatarView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
            make.width.height.equalTo(UX.AvatarSize)
        }
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.avatarView.snp_bottom).offset(UX.NameOffset)
            make.width.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
        }
    }
}
