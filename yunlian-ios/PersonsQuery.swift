//
//  PersonsQuery.swift
//  yunlian-ios
//
//  Created by zikang zou on 30/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import Foundation

class PersonsQuery {
    
    var dic = Dictionary<String, [Person]>()
    
    func count(key: String) -> Int {
        if dic.keys.contains(key) {
            return dic[key]!.count
        } else {
            return Database.sharedInstance.countPersons(key)
        }
    }
    
    func lookUp(key: String) -> [Person]? {
        if dic.keys.contains(key) {
            return dic[key]
        } else {
            let persons = Database.sharedInstance.fetchPersons(key)
            dic[key] = persons
            return persons
        }
    }
}
