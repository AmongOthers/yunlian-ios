//
//  CalendarTableViewCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/29.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    
    struct UX {
        static let HeaderBarHeight:CGFloat = 12.5
        static let ContentOffset:CGFloat = 8
        static let TimeSquareSize:CGFloat = 52
        static let TitleOffset:CGFloat = 11
        static let TimeLabelOffset:CGFloat = 6
    }
    
    var headerBarView: UIView!
    var timeSquareView: UIView!
    var startTimeLabel: UILabel!
    var endTimeLabel: UILabel!
    var titleLabel: UILabel!
    var locationLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.whiteColor()
        headerBarView = UIView()
        contentView.addSubview(headerBarView)
        headerBarView.backgroundColor = UIConstants.BackgroundGray
        timeSquareView = UIView()
        contentView.addSubview(timeSquareView)
        timeSquareView.backgroundColor = UIConstants.BackgroundGray
        startTimeLabel = UILabel()
        contentView.addSubview(startTimeLabel)
        startTimeLabel.font = UIConstants.DefaultMediumFont
        startTimeLabel.textColor = UIConstants.TintColorGreen
        endTimeLabel = UILabel()
        contentView.addSubview(endTimeLabel)
        endTimeLabel.font = UIConstants.DefaultMediumFont
        endTimeLabel.textColor = UIConstants.TintColor
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UIConstants.DefaultMediumFont
        titleLabel.textColor = UIConstants.FontColorGray
        locationLabel = UILabel()
        contentView.addSubview(locationLabel)
        locationLabel.font = UIConstants.DefaultSmallFont
        locationLabel.textColor = UIConstants.FontColorSecondGray
    }
    
    func setupConstraints() {
        headerBarView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(self.contentView)
            make.height.equalTo(UX.HeaderBarHeight)
            make.top.equalTo(self.contentView)
        }
        timeSquareView.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.TimeSquareSize)
            make.top.equalTo(self.headerBarView.snp_bottom).offset(UX.ContentOffset)
            make.left.equalTo(self.contentView).offset(UX.ContentOffset)
        }
        startTimeLabel.snp_remakeConstraints { (make) -> Void in
            make.centerX.equalTo(self.timeSquareView)
            make.top.equalTo(self.timeSquareView).offset(UX.TimeLabelOffset)
        }
        endTimeLabel.snp_remakeConstraints { (make) -> Void in
            make.centerX.equalTo(self.timeSquareView)
            make.bottom.equalTo(self.timeSquareView).offset(-UX.TimeLabelOffset)
        }
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self.timeSquareView.snp_right).offset(UX.TitleOffset)
            make.top.equalTo(self.timeSquareView)
        }
        locationLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp_bottom).offset(UX.ContentOffset)
        }
    }

}
