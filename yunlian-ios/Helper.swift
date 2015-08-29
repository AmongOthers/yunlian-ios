//
//  Util.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/19.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import Foundation
import SnapKit

class Helper {
    class func fataErrorNotImplemented() {
        fatalError("NotImplemented")
    }
    
    class func panelView(parentView: UIView, target: AnyObject, action: Selector) -> (mask: UIView, panel: UIView) {
        let mask = UIView()
        parentView.addSubview(mask)
        mask.backgroundColor = UIColor.clearColor()
        mask.userInteractionEnabled = true
        mask.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        mask.snp_remakeConstraints { (make) -> Void in
            make.width.height.centerX.centerY.equalTo(parentView)
        }
        let panel = UIView()
        mask.addSubview(panel)
        parentView.bringSubviewToFront(mask)
        return (mask, panel)
        
//        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        window.windowLevel = UIWindowLevelAlert
//        window.backgroundColor = UIColor.clearColor()
//        window.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
//        let panel = UIView()
//        window.addSubview(panel)
//        return (window, panel)
    }
}