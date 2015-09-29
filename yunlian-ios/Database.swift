//
//  Database.swift
//  yunlian-ios
//
//  Created by zikang zou on 29/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import Foundation

enum RelationshipType: Int {
    case Friend = 0
    case Oneway = 1
    case Blacklist = 2
}

class Database {
    
    private static let instance = Database()
    
    private init() {
        
    }
    
    let ContactTableDef: [String: SwiftData.DataType] = ["Name": .StringVal, "Title": .StringVal,  "AvatarUrl": .StringVal, "UserId": .StringVal, "YunlianId": .StringVal, "Relationship": .IntVal]
    class var sharedInstance: Database {
        return instance
    }
    
    func initDatabase() {
        let (tables, _) = SD.existingTables()
        if tables.count == 0 {
            SD.createTable("Contacts", withColumnNamesAndTypes: ContactTableDef)
            seed()
        }
    }
    
    func seed() {
        let seedPerson: [Person] = [Person(name: "马云", title: "阿里巴巴董事长", avatar: "1"), Person(name: "刘强东", title: "京东商城CEO", avatar: "2"), Person(name: "罗洪鹏", title: "蜂助手CEO", avatar: "3")]
        seedPerson.forEach { (person) -> () in
            SD.executeChange("INSERT INTO Contacts (Name, Title, AvatarUrl, Relationship) VALUES (?, ?, ?, ?) ", withArgs: [person.name, person.title, person.avatar, RelationshipType.Friend.rawValue])
        }
    }
    
    func fetchPersons() -> [Person]? {
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Contacts WHERE Relationship = ?", withArgs: [RelationshipType.Friend.rawValue])
        if err == nil {
            var persons = [Person]()
            resultSet.forEach({ (row) -> () in
                let name = row["Name"]?.asString()
                let title = row["Title"]?.asString()
                let avatar = row["AvatarUrl"]?.asString()
                let person = Person(name: name!, title: title!, avatar: avatar!)
                persons.append(person)
            })
            return persons
        }
        return nil
    }
}
