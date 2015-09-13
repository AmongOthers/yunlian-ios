//
//  ProfileRemarkSectionHeaderView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/12.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ProfileRemarkSectionHeaderView: UITableViewHeaderFooterView {

    
    struct UX {
        static let TitleOffset:CGFloat = 13
        static let SeperatorColor = UIColor(rgb: 0xd9dde0)
        static let SeperatorOffset = 8
    }
    
    var titleLabel: UILabel!
    var seperatorView: UIView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor.whiteColor()
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UIConstants.DefaultMediumFont
        seperatorView = UIView()
        contentView.addSubview(seperatorView)
        seperatorView.backgroundColor = UX.SeperatorColor
    }
    
    func setupConstraints() {
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView.snp_left).offset(UX.TitleOffset)
            make.centerY.equalTo(self.contentView)
        }
        seperatorView.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(UX.SeperatorOffset)
            make.right.equalTo(self).offset(-UX.SeperatorOffset)
        }
    }

}
