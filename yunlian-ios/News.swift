//
//  News.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/6.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import Foundation

class News {
    let person: Person
    let title: String
    let date: NSDate
    let dateDescription: String
    let locationDescription: String
    let notifyDescription: String
    
    init(person: Person) {
        self.person = person
        self.title = "今晚有空吗？出来吃个饭呗"
        self.date = NSDate()
        self.dateDescription = "今天下午6点至8点"
        self.locationDescription = "龙口西路食街老地方"
        self.notifyDescription = "到期前半小时提醒"
    }
}