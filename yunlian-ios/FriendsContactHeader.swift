//
//  FriendsContactHeader.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/18.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class FriendsContactHeader: UITableViewHeaderFooterView {
    struct UX {
        static let LabelFont = UIFont.systemFontOfSize(15)
        static let LabelOffset = 15
    }
    
    var label: UILabel!
    
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
        label = UILabel()
        contentView.addSubview(label)
        label.font = UX.LabelFont
        label.textColor = UIConstants.FontColorGray
    }
    
    func setupConstraints() {
        label.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(UX.LabelOffset)
        }
    }
    
}
