//
//  CalendarHeaderView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/28.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class CalendarHeaderView: UICollectionReusableView {
    
    struct UX {
        static let HeaderFont = UIFont.systemFontOfSize(14)
        static let SeperatorColor = UIColor(rgb: 0xd9dde0)
        static let HeaderFontTextColor = UIColor(rgb: 0xa1a1a1)
        static let SeperatorOffset = 15
    }
    
    var weekdayLabels = [UILabel]()
    var weekdayTexts = ["日", "一", "二", "三", "四", "五", "六"]
    var seperatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        for index:Int in 0...6 {
            let label = UILabel()
            addSubview(label)
            label.font = UX.HeaderFont
            label.textAlignment = NSTextAlignment.Center
            if index == 0 || index == 6 {
                label.textColor = UIConstants.TintColor
            } else {
                label.textColor = UX.HeaderFontTextColor
            }
            label.text = weekdayTexts[index]
            weekdayLabels.append(label)
        }
        seperatorView = UIView()
        addSubview(seperatorView)
        seperatorView.backgroundColor = UX.SeperatorColor
    }
    
    func setupConstraints() {
        let width = (UIScreen.mainScreen().bounds.width - CalendarViewController.UX.CalendarOffset) / 7
        var index:CGFloat = 0
        for label in weekdayLabels {
            label.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(width)
                make.centerY.equalTo(self)
                make.left.equalTo(self.snp_left).offset(index * width)
            })
            index++
        }
        seperatorView.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(UX.SeperatorOffset)
            make.right.equalTo(self.snp_right).offset(-UX.SeperatorOffset)
            make.top.equalTo(self.snp_bottom)
            make.height.equalTo(0.5)
        }
    }
}
