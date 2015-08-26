//
//  ProfileSectionHeaderView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/25.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ProfileSectionHeaderView: UITableViewHeaderFooterView {
    
    struct UX {
        static let BarTintColor = UIColor(rgb: 0x56c119)
        static let BarWidth:CGFloat = 8
        static let BarHeight:CGFloat = 28.5
        static let TitleOffset:CGFloat = 5
    }
    
    var barView: UIView!
    var titleLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.clearColor()
        barView = UIView()
        contentView.addSubview(barView)
        barView.backgroundColor = UX.BarTintColor
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UIConstants.DefaultStandardFont
    }
    
    func setupConstraints() {
        barView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(UX.BarWidth)
            make.height.equalTo(UX.BarHeight)
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
        }
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self.barView.snp_right).offset(UX.TitleOffset)
            make.centerY.equalTo(self.contentView)
        }
    }

}
