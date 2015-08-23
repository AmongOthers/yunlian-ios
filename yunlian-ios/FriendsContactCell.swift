//
//  FriendsContactCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/18.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class FriendsContactCell: UITableViewCell {
    struct UX {
        static let AvatarSize:CGFloat = 42.5
        static let ImageOffset = 15
        static let SeperatorOffset = 8
        static let TextOffset = 10
        static let NameTopOffset = 10
        static let TitleTopOffset = 5
        static let SeperatorColor = UIColor(rgb: 0xd9dde0)
    }
   
    var isConstraintInstalled = false
    var seperatorView: UIView!
    var nameLabel: UILabel!
    var titleLabel: UILabel!
    var avatarView: UIImageView!
    
    var isLastCell = false {
        didSet {
            seperatorView.hidden = self.isLastCell
        }
    }
     
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        nameLabel.font = UIConstants.DefaultMediumFont
        nameLabel.textColor = UIConstants.FontColorGray
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UIConstants.DefaultSmallFont
        titleLabel.textColor = UIConstants.FontColorSecondGray
        avatarView = UIImageView()
        contentView.addSubview(avatarView)
        avatarView.contentMode = UIViewContentMode.ScaleAspectFill
        avatarView.layer.cornerRadius = UX.AvatarSize / 2
        avatarView.clipsToBounds = true
        seperatorView = UIView()
        contentView.addSubview(seperatorView)
        seperatorView.backgroundColor = UX.SeperatorColor
    }
    
    func setupConstraints() {
        nameLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(UX.NameTopOffset)
            make.left.equalTo(self.avatarView.snp_right).offset(UX.TextOffset)
        }
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.nameLabel.snp_bottom).offset(UX.TitleTopOffset)
            make.left.equalTo(self.avatarView.snp_right).offset(UX.TextOffset)
        }
        avatarView.snp_remakeConstraints(closure: { (make) -> Void in
            make.width.height.equalTo(UX.AvatarSize)
            make.left.equalTo(self.contentView).offset(UX.ImageOffset)
            make.centerY.equalTo(self.contentView)
        })
        seperatorView.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(UX.SeperatorOffset)
            make.right.equalTo(self).offset(-UX.SeperatorOffset)
        }
    }
}