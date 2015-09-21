//
//  MoreAlertCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/21.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class MoreAlertCell: UITableViewCell {
    
    struct UX {
        static let SideOffset = 0
        static let IconSize = 30
        static let SeperatorColor = UIColor(rgb: 0xd9dde0)
    }
    
    var actionLabel: UILabel!
    var actionIcon: UIImageView!
    var seperatorView: UIView!
    var isLastCell = false {
        didSet {
            seperatorView.hidden = self.isLastCell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        actionLabel = UILabel()
        contentView.addSubview(actionLabel)
        actionLabel.textColor = UIConstants.TintColor
        actionLabel.font = UIConstants.DefaultBigFont
        actionIcon = UIImageView()
        contentView.addSubview(actionIcon)
        seperatorView = UIView()
        contentView.addSubview(seperatorView)
        seperatorView.backgroundColor = UX.SeperatorColor
    }
    
    func setupConstraints() {
        actionLabel.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(UX.SideOffset)
        }
        actionIcon.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-UX.SideOffset)
            make.width.height.equalTo(UX.IconSize)
        }
        seperatorView.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }
}
