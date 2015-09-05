//
//  MySwiftDate.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/30.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import Foundation

extension NSDate {
    class func localToday() -> NSDate! {
        let zone = NSTimeZone.localTimeZone()
        return today(zone.abbreviation)
    }
}