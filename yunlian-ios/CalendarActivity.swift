//
//  CalendarActivity.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/30.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import Foundation


@objc
class CalendarActivity: NSObject {
    
    var title: String
    var location: String
    var startTime: NSDate
    var endTime: NSDate
    var isPeopleShowed = false
    var persons = [Person]()
    
    init(title: String, location: String, startTime: NSDate, endTime: NSDate) {
        self.title = title
        self.location = location
        self.startTime = startTime
        self.endTime = endTime
    }
    
}
