//
//  SignatureCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/26.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class SignatureCell: ProfileCell {
    
    var textView: UITextView!
    
    override func setupViews() {
        super.setupViews()
        textView = UITextView()
        contentView.addSubview(textView)
        textView.editable = false
        textView.font = UIConstants.DefaultMediumFont
        textView.text = "努力工作，努力赚钱，养得起老婆，对了，我TMD的还没有老婆"
        textView.textColor = UIConstants.FontColorSecondGray
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        textView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
    }

}
