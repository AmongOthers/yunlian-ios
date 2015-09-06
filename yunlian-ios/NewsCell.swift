//
//  NewsCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/6.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    struct UX {
        static let SideOffset: CGFloat = 8
        static let LineOffset: CGFloat = 55
        static let LineHeight: CGFloat = 18
        static let LineWidth: CGFloat = 2
        static let LineColor: UIColor = UIColor(rgb: 0xdedede)
        static let AvatarSize: CGFloat = 42.5
        static let ImageOffset = 8
        static let TextOffset = 10
        static let NameTopOffset = 10
        static let TitleTopOffset = 5
        static let TextTopOffset: CGFloat = 12.5
        static let TextLeftOffset: CGFloat = 4
        static let TimeLabelOffset: CGFloat = 8
        static let ButtonBottomOffset: CGFloat = 12
        static let ButtonMiddleOffset: CGFloat = 15
        static let ButtonWidth: CGFloat = 80
    }
    
    var lineView: UIView!
    var innerView: UIView!
    var avatarView: UIImageView!
    var nameLabel: UILabel!
    var titleLabel: UILabel!
    var newsTitleLabel: UILabel!
    var dateNotationLabel: UILabel!
    var locationNotationLabel: UILabel!
    var notifyNotationabel: UILabel!
    var dateDescriptionLabel: UILabel!
    var locationDescriptionLabel: UILabel!
    var notifyDescriptionLabel: UILabel!
    var timeLabel: UILabel!
    var acceptButton: UIButton!
    var declineButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.clearColor()
        lineView = UIView()
        contentView.addSubview(lineView)
        lineView.backgroundColor = UX.LineColor
        innerView = UIView()
        contentView.addSubview(innerView)
        innerView.backgroundColor = UIColor.whiteColor()
        innerView.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
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
        newsTitleLabel = UILabel()
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.font = UIConstants.DefaultMediumFont
        newsTitleLabel.textColor = UIConstants.FontColorGray
        dateNotationLabel = UILabel()
        contentView.addSubview(dateNotationLabel)
        dateNotationLabel.text = "时间："
        dateNotationLabel.font = UIConstants.DefaultMediumFont
        dateNotationLabel.textColor = UIConstants.FontColorSecondGray
        locationNotationLabel = UILabel()
        contentView.addSubview(locationNotationLabel)
        locationNotationLabel.text = "地点："
        locationNotationLabel.font = UIConstants.DefaultMediumFont
        locationNotationLabel.textColor = UIConstants.FontColorSecondGray
        notifyNotationabel = UILabel()
        contentView.addSubview(notifyNotationabel)
        notifyNotationabel.text = "提醒："
        notifyNotationabel.font = UIConstants.DefaultMediumFont
        notifyNotationabel.textColor = UIConstants.FontColorSecondGray
        dateDescriptionLabel = UILabel()
        contentView.addSubview(dateDescriptionLabel)
        dateDescriptionLabel.font = UIConstants.DefaultMediumFont
        dateDescriptionLabel.textColor = UIConstants.FontColorGray
        locationDescriptionLabel = UILabel()
        contentView.addSubview(locationDescriptionLabel)
        locationDescriptionLabel.font = UIConstants.DefaultMediumFont
        locationDescriptionLabel.textColor = UIConstants.FontColorGray
        notifyDescriptionLabel = UILabel()
        contentView.addSubview(notifyDescriptionLabel)
        notifyDescriptionLabel.font = UIConstants.DefaultMediumFont
        notifyDescriptionLabel.textColor = UIConstants.FontColorGray
        timeLabel = UILabel()
        contentView.addSubview(timeLabel)
        timeLabel.font = UIConstants.DefaultMediumFont
        timeLabel.textColor = UIConstants.FontColorGray
        acceptButton = UIButton()
        contentView.addSubview(acceptButton)
        acceptButton.setTitle("接受", forState: UIControlState.Normal)
        acceptButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        acceptButton.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        acceptButton.backgroundColor = UIConstants.TintColorGreen
        acceptButton.titleLabel?.font = UIConstants.DefaultMediumFont
        declineButton = UIButton()
        contentView.addSubview(declineButton)
        declineButton.setTitle("拒绝", forState: UIControlState.Normal)
        declineButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        declineButton.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        declineButton.backgroundColor = UIConstants.TintColor
        declineButton.titleLabel?.font = UIConstants.DefaultMediumFont
    }
    
    func setupConstraints() {
        lineView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(UX.LineWidth)
            make.height.equalTo(UX.LineHeight)
            make.left.equalTo(contentView).offset(UX.LineOffset)
            make.top.equalTo(contentView)
        }
        innerView.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(UX.SideOffset)
            make.right.equalTo(contentView).offset(-UX.SideOffset)
            make.top.equalTo(lineView.snp_bottom)
            make.bottom.equalTo(contentView)
        }
        nameLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.innerView).offset(UX.NameTopOffset)
            make.left.equalTo(self.avatarView.snp_right).offset(UX.TextOffset)
        }
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.nameLabel.snp_bottom).offset(UX.TitleTopOffset)
            make.left.equalTo(self.avatarView.snp_right).offset(UX.TextOffset)
        }
        avatarView.snp_remakeConstraints(closure: { (make) -> Void in
            make.width.height.equalTo(UX.AvatarSize)
            make.left.equalTo(self.innerView).offset(UX.ImageOffset)
            make.top.equalTo(self.innerView).offset(UX.ImageOffset)
        })
        newsTitleLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(avatarView)
            make.top.equalTo(titleLabel.snp_bottom).offset(UX.TextTopOffset)
        }
        dateNotationLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(avatarView).offset(UX.TextLeftOffset)
            make.top.equalTo(newsTitleLabel.snp_bottom).offset(UX.TextTopOffset)
        }
        locationNotationLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(avatarView).offset(UX.TextLeftOffset)
            make.top.equalTo(dateNotationLabel.snp_bottom).offset(UX.TextTopOffset)
        }
        notifyNotationabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(avatarView).offset(UX.TextLeftOffset)
            make.top.equalTo(locationNotationLabel.snp_bottom).offset(UX.TextTopOffset)
        }
        dateDescriptionLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(dateNotationLabel.snp_right)
            make.top.equalTo(dateNotationLabel)
        }
        locationDescriptionLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(locationNotationLabel.snp_right)
            make.top.equalTo(locationNotationLabel)
        }
        notifyDescriptionLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(notifyNotationabel.snp_right)
            make.top.equalTo(notifyNotationabel)
        }
        timeLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel)
            make.right.equalTo(innerView).offset(-UX.TimeLabelOffset)
        }
        acceptButton.snp_remakeConstraints { (make) -> Void in
            make.bottom.equalTo(innerView).offset(-UX.ButtonBottomOffset)
            make.right.equalTo(innerView.snp_centerX).offset(-UX.ButtonMiddleOffset)
            make.width.equalTo(UX.ButtonWidth)
        }
        declineButton.snp_remakeConstraints { (make) -> Void in
            make.bottom.equalTo(innerView).offset(-UX.ButtonBottomOffset)
            make.left.equalTo(innerView.snp_centerX).offset(UX.ButtonMiddleOffset)
            make.width.equalTo(UX.ButtonWidth)
        }
    }
}