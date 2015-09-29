//
//  Person.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/19.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import Foundation

class Person {
    var name: String
    var title: String
    var avatar: String
    var image: UIImage? {
        get {
            return UIImage(named: avatar)
        }
    }
//    var signature: String
//    var telephone: String
//    var mail: String
    
    init(name: String, title: String, avatar: String) {
        self.name = name
        self.title = title
        self.avatar = avatar
    }
}