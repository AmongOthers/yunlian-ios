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
        static let PeopleBarHeight:CGFloat = 73
        static let ArrowRightOffset = 8
        static let ArrowSize = 18
        static let ArrowTouchSize = 40
        static let PersonCellWidth:CGFloat = 50
        static let CollectionViewVerticalInsets:CGFloat = 6
        static let CollectionViewHorizontalInsets:CGFloat = 4
    }
    
    var activity: CalendarActivity? {
        didSet {
            titleLabel.text = activity?.title
            locationLabel.text = activity?.location
            startTimeLabel.text = activity?.startTime.toString(format: DateFormat.Custom("HH:mm"))
            endTimeLabel.text = activity?.endTime.toString(format: DateFormat.Custom("HH:mm"))
        }
    }
    
    var headerBarView: UIView!
    // 加一个遮罩在推出头像的时候可以避免头像区域出现在上部区域
    var frontView: UIView!
    var timeSquareView: UIView!
    var startTimeLabel: UILabel!
    var endTimeLabel: UILabel!
    var titleLabel: UILabel!
    var locationLabel: UILabel!
    var peopleBar: UIView!
    var toggleView: UIView!
    var arrowImageView: UIView!
    var personCollectionView: UICollectionView!
    
    let PersonCellIdentifier = "PersonCellIdentifier"
    
    weak var delegate: CalendarTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.whiteColor()
        
        peopleBar = UIView()
        contentView.addSubview(peopleBar)
        peopleBar.backgroundColor = UIConstants.BackgroundGray.colorWithAlphaComponent(0.5)
        peopleBar.hidden = true
        
        frontView = UIView()
        contentView.addSubview(frontView)
        frontView.backgroundColor = UIColor.whiteColor()
        
        timeSquareView = UIView()
        frontView.addSubview(timeSquareView)
        timeSquareView.backgroundColor = UIConstants.BackgroundGray
        startTimeLabel = UILabel()
        frontView.addSubview(startTimeLabel)
        startTimeLabel.font = UIConstants.DefaultMediumFont
        startTimeLabel.textColor = UIConstants.TintColorGreen
        endTimeLabel = UILabel()
        frontView.addSubview(endTimeLabel)
        endTimeLabel.font = UIConstants.DefaultMediumFont
        endTimeLabel.textColor = UIConstants.TintColor
        titleLabel = UILabel()
        frontView.addSubview(titleLabel)
        titleLabel.font = UIConstants.DefaultMediumFont
        titleLabel.textColor = UIConstants.FontColorGray
        locationLabel = UILabel()
        frontView.addSubview(locationLabel)
        locationLabel.font = UIConstants.DefaultSmallFont
        locationLabel.textColor = UIConstants.FontColorSecondGray

        toggleView = UIView()
        frontView.addSubview(toggleView)
        toggleView.backgroundColor = UIColor.clearColor()
        toggleView.userInteractionEnabled = true
        toggleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "toggleTapped"))
        arrowImageView = UIImageView(image: UIImage(named: "up"))
        toggleView.addSubview(arrowImageView)
        arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(UX.PersonCellWidth, UX.PeopleBarHeight - UX.CollectionViewVerticalInsets * 2)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.sectionInset = UIEdgeInsetsMake(UX.CollectionViewHorizontalInsets, UX.CollectionViewVerticalInsets, UX.CollectionViewHorizontalInsets, UX.CollectionViewVerticalInsets)
        personCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        peopleBar.addSubview(personCollectionView)
        personCollectionView.backgroundColor = UIColor.whiteColor()
        personCollectionView.delegate = self
        personCollectionView.dataSource = self
        personCollectionView.bounces = false
        personCollectionView.registerClass(PersonCell.self, forCellWithReuseIdentifier: PersonCellIdentifier)
        
        headerBarView = UIView()
        contentView.addSubview(headerBarView)
        headerBarView.backgroundColor = UIConstants.BackgroundGray
        
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
            make.left.equalTo(self.contentView)
        }
        frontView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(self.contentView)
            make.height.equalTo(CalendarViewController.UX.TabelRowHeight - UX.HeaderBarHeight)
            make.top.equalTo(self.headerBarView.snp_bottom)
            make.left.equalTo(self.contentView)
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
        personCollectionView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(self.peopleBar)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if contentView.frame.height > CalendarViewController.UX.TabelRowHeight {
            open()
        } else {
            close()
        }
    }
    
}

extension CalendarTableViewCell: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PersonCellIdentifier, forIndexPath: indexPath) as! PersonCell
        if let person = activity?.persons[indexPath.row] {
            cell.titleLabel.text = person.name
            cell.avatarView.image = UIImage(named: person.avatar)
        }
        return cell
    }
}

extension CalendarTableViewCell: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activity?.persons.count ?? 0
    }
}

