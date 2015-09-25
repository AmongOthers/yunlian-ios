//
//  UILabelWithInset.swift
//  yunlian-ios
//
//  Created by zikang zou on 25/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class UILabelWithInsets: UILabel {
    
    var insets: UIEdgeInsets?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    convenience init(frame: CGRect, insets: UIEdgeInsets) {
        self.init(frame: frame)
        self.insets = insets
    }
    
    override func drawTextInRect(rect: CGRect) {
        if let insets = insets {
            super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
        }
    }
}
