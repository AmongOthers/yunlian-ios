//
//  TextFieldLeftView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

struct TextFieldLeftViewUX {
    static let LineWidth = 1
    static let LineHeight = 24
    static let LineHorizontalOffset = 4
}

class TextFieldLeftView: UIView {
    private var imageView: UIImageView!
    private var lineView: UIView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        imageView = UIImageView()
        addSubview(imageView)
        imageView.image = image
        lineView = UIView()
        addSubview(lineView)
        lineView.backgroundColor = UIConstants.FirstGray.colorWithAlphaComponent(0.2)
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp_remakeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(-TextFieldLeftViewUX.LineHorizontalOffset / 2)
        }
        lineView.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(TextFieldLeftViewUX.LineWidth)
            make.height.equalTo(TextFieldLeftViewUX.LineHeight)
            make.right.equalTo(self.snp_right).offset(-TextFieldLeftViewUX.LineHorizontalOffset)
            make.centerY.equalTo(self)
        }
    }
}
