//
//  NewsHeader.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/6.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class NewsHeader: UITableViewHeaderFooterView {
    struct UX {
        static let Background = UIConstants.BackgroundColor
        static let SideOffset:CGFloat = 8
        static let LabelHeight:CGFloat = 25
    }
    
    var label: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        label = UIButton()
        contentView.addSubview(label)
        contentView.backgroundColor = UIConstants.BackgroundGray
        label.contentEdgeInsets = UIEdgeInsets(top: UX.SideOffset, left: 1.5 * UX.SideOffset, bottom: UX.SideOffset, right:  1.5 * UX.SideOffset)
        label.titleLabel?.font = UIConstants.DefaultMediumFont
        label.titleLabel?.textColor = UIColor.whiteColor()
        label.backgroundColor = UX.Background
        label.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        label.clipsToBounds = true
        label.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func setupConstraints() {
        label.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(UX.SideOffset)
            make.bottom.equalTo(contentView)
            make.height.equalTo(UX.LabelHeight)
        }
    }
}