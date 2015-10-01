//
//  ActivityTimespanCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ActivityTimespanCell: ActivityBaseCell {
    
    var spanLabel: UILabel!
    
    override func setupViews() {
        super.setupViews()
        spanLabel = UILabel()
        contentView.addSubview(spanLabel)
        spanLabel.font = UIConstants.DefaultMediumFont
        spanLabel.textColor = UIConstants.FontColorGray
        spanLabel.textAlignment = NSTextAlignment.Right
        spanLabel.text = "2小时"
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        spanLabel.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-UX.RightOffset)
            make.left.equalTo(label.snp_right).offset(UX.TextOffset)
            make.centerY.equalTo(contentView)
        }
    }
}
