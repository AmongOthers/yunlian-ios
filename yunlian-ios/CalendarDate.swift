//
//  CalendarData.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/28.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import Foundation

class CalendarDate {
    
    var initDate: NSDate
    var currentDate: NSDate
    var startIndex:Int {
        get {
            return currentDate.beginningOfMonth.weekday - 1
        }
    }
    var monthDays:Int {
        get {
            return currentDate.monthDays()
        }
    }
    var today:NSDate {
        get {
            let zone = NSTimeZone.localTimeZone()
            return NSDate.today(tz: zone.abbreviation)
        }
    }
    
    init() {
        let zone = NSTimeZone.localTimeZone()
        initDate = NSDate.today(tz: zone.abbreviation)
        currentDate = initDate
    }
    
    func nextMonth() {
        currentDate = currentDate.endOfMonth + 1.day
    }
    
    func previousMonth() {
        currentDate = currentDate.beginningOfMonth - 1.day
    }
}
