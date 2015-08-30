//
//  CalendarTableViewCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/29.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

@objc
protocol CalendarTableViewCellDelegate {
    func toggleTapped(activity: CalendarActivity)
}

class CalendarTableViewCell: UITableViewCell {
    
    struct UX {
        static let HeaderBarHeight:CGFloat = 12.5
        static let ContentOffset:CGFloat = 8
        static let TimeSquareSize:CGFloat = 52
        static let TitleOffset:CGFloat = 11
        static let TimeLabelOffset:CGFloat = 6
        static let AvatarSize:CGFloat = 42.5
        static let PeopleBarHeight:CGFloat = 73
        static let ArrowRightOffset = 8
        static let ArrowSize = 18
        static let ArrowTouchSize = 40
    }
    
    var activity: CalendarActivity! {
        didSet {
            titleLabel.text = activity.title
            locationLabel.text = activity.location
            startTimeLabel.text = "\(activity.startTime.hour):\(activity.startTime.minute)"
            endTimeLabel.text = "\(activity.endTime.hour):\(activity.endTime.minute)"
        }
    }
    
    var headerBarView: UIView!
    var timeSquareView: UIView!
    var startTimeLabel: UILabel!
    var endTimeLabel: UILabel!
    var titleLabel: UILabel!
    var locationLabel: UILabel!
    var peopleBar: UIView!
    var toggleView: UIView!
    var arrowImageView: UIView!
    
    weak var delegate: CalendarTableViewCellDelegate?
    
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
        peopleBar = UIView()
        contentView.addSubview(peopleBar)
        peopleBar.backgroundColor = UIConstants.BackgroundGray.colorWithAlphaComponent(0.5)
        peopleBar.hidden = true
        toggleView = UIView()
        contentView.addSubview(toggleView)
        toggleView.backgroundColor = UIColor.clearColor()
        toggleView.userInteractionEnabled = true
        toggleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "toggleTapped"))
        arrowImageView = UIImageView(image: UIImage(named: "up"))
        toggleView.addSubview(arrowImageView)
        arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }
    
    func toggleTapped() {
        delegate?.toggleTapped(activity!)
    }
    
    func open() {
        peopleBar.hidden = false
        self.arrowImageView.transform = CGAffineTransformIdentity
    }
    
    func close() {
        peopleBar.hidden = true
        self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
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
        peopleBar.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(self.contentView)
            make.height.equalTo(UX.PeopleBarHeight)
            make.left.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
        toggleView.snp_remakeConstraints { (make) -> Void in
            make.right.top.equalTo(self.contentView)
            make.width.equalTo(UX.ArrowTouchSize)
            make.height.equalTo(CalendarViewController.UX.TabelRowHeight)
        }
        arrowImageView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self.toggleView).offset(-UX.ArrowRightOffset)
            make.centerY.equalTo(self.toggleView)
            make.width.height.equalTo(UX.ArrowSize)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        println("layoutSubViews:\(contentView.frame.width):\(contentView.frame.height)")
        if contentView.frame.height > CalendarViewController.UX.TabelRowHeight {
            open()
        } else {
            close()
        }
    }
    
    override func layoutMarginsDidChange() {
        println("marginDidChaged")
    }

}
