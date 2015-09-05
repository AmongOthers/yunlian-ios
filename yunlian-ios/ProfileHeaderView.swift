//
//  ProfileHeaderView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/24.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

@objc
protocol ProfileHeaderViewDelegate {
    func qrCodeTapped()
}

class ProfileHeaderView: UIView {
    struct UX {
        static let SideOffset:CGFloat = 8
        static let AvatarSize:CGFloat = 42.5
        static let ImageOffset = 8
        static let TextOffset = 10
        static let NameTopOffset = 12
        static let TitleTopOffset = 5
        static let IdLabelTopOffset = 5
        static let QrCodeImageSize:CGFloat = 44
    }
    
    var avatarView: UIImageView!
    var contentView: UIView!
    var nameLabel: UILabel!
    var titleLabel: UILabel!
    var idLabel: UILabel!
    var qrCodeView: UIImageView!
    weak var delegate: ProfileHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView = UIView()
        addSubview(contentView)
        contentView.backgroundColor = UIColor.whiteColor()
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        nameLabel.text = "郑文伟"
        nameLabel.font = UIConstants.DefaultMediumFont
        nameLabel.textColor = UIConstants.FontColorGray
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.text = "高级软件工程师"
        titleLabel.font = UIConstants.DefaultSmallFont
        titleLabel.textColor = UIConstants.FontColorSecondGray
        avatarView = UIImageView()
        contentView.addSubview(avatarView)
        avatarView.image = UIImage(named: "1")
        avatarView.contentMode = UIViewContentMode.ScaleAspectFill
        avatarView.layer.cornerRadius = UX.AvatarSize / 2
        avatarView.clipsToBounds = true
        idLabel = UILabel()
        contentView.addSubview(idLabel)
        idLabel.text = "云联ID: 145895"
        idLabel.font = UIConstants.DefaultMediumFont
        idLabel.textColor = UIConstants.FontColorSecondGray
        qrCodeView = UIImageView()
        contentView.addSubview(qrCodeView)
        let qrCodeImage = UIImage(named: "qrCode")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        qrCodeView.tintColor = UIConstants.TintColor
        qrCodeView.image = qrCodeImage
        qrCodeView.userInteractionEnabled = true
        qrCodeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "qrCodeTapped"))
    }
    
    func qrCodeTapped() {
        delegate?.qrCodeTapped()
    }
    
    func setupConstraints() {
        contentView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(UX.SideOffset)
            make.left.equalTo(self).offset(UX.SideOffset)
            make.right.equalTo(self).offset(-UX.SideOffset)
            make.bottom.equalTo(self)
        }
        avatarView.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.AvatarSize)
            make.top.equalTo(self.contentView).offset(UX.ImageOffset)
            make.left.equalTo(self.contentView).offset(UX.ImageOffset)
        }
        nameLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(UX.NameTopOffset)
            make.left.equalTo(self.avatarView.snp_right).offset(UX.TextOffset)
        }
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.nameLabel.snp_bottom).offset(UX.TitleTopOffset)
            make.left.equalTo(self.avatarView.snp_right).offset(UX.TextOffset)
        }
        idLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.avatarView.snp_bottom).offset(UX.IdLabelTopOffset)
            make.left.equalTo(self.avatarView)
        }
        qrCodeView.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.QrCodeImageSize)
            make.right.equalTo(self.contentView).offset(-UX.ImageOffset)
            make.centerY.equalTo(self.contentView)
        }
    }
    
}
