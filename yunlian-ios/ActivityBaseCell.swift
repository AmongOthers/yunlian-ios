//
//  ActivityBaseCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ActivityBaseCell: UITableViewCell {
    
    struct UX {
        static let LeftOffset: CGFloat = 18
        static let RightOffset: CGFloat = 18
        static let TextOffset: CGFloat = 10
        static let SeperatorColor = UIColor(rgb: 0xd9dde0)
        static let TextHeight: CGFloat = 32
        static let ImageSize: CGFloat = 30
        static let PersonCellWidth:CGFloat = 30
        static let PersonCellHeight:CGFloat = 30
        static let CollectionViewVerticalInsets:CGFloat = 6
        static let CollectionViewHorizontalInsets:CGFloat = 4
    }
    
    var label: UILabel!
    var seperatorView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        label = UILabel()
        contentView.addSubview(label)
        label.font = UIConstants.DefaultMediumFont
        label.textColor = UIConstants.FontColorSecondGray
        seperatorView = UIView()
        contentView.addSubview(seperatorView)
        seperatorView.backgroundColor = UX.SeperatorColor
    }
    
    func setupConstraints() {
        label.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        label.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(UX.LeftOffset)
            make.centerY.equalTo(contentView)
        }
        seperatorView.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView).offset(UX.LeftOffset)
            make.right.equalTo(contentView)
        }
    }
}
