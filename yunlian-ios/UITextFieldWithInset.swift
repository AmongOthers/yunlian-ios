//
//  UITextFieldWithInset.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/23.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class UITextFieldWithInsets: UITextField {
    
    var insetX: CGFloat = 0
    var insetY: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    convenience init(frame: CGRect, insetX: CGFloat, insetY: CGFloat) {
        self.init(frame: frame)
        self.insetX = insetX
        self.insetY = insetY
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }

}
