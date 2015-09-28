//
//  MineAvatarCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 28/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ModifyInfoBaseCell: UITableViewCell {
    
    struct UX {
        static let LeftOffset: CGFloat = 18
        static let SeperatorColor = UIColor(rgb: 0xd9dde0)
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
