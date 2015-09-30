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
    
    lazy var HanyuFormat: HanyuPinyinOutputFormat = {
        let outputFormat = HanyuPinyinOutputFormat()
        outputFormat.toneType = ToneTypeWithoutTone
        outputFormat.vCharType = VCharTypeWithV
        outputFormat.caseType = CaseTypeUppercase
        return outputFormat
    }()
    
    let ContactTableDef: [String: SwiftData.DataType] = ["Key": .StringVal, "Pinyin": .StringVal, "Name": .StringVal, "Title": .StringVal,  "AvatarUrl": .StringVal, "UserId": .StringVal, "YunlianId": .StringVal, "Relationship": .IntVal]
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
        let seedPerson: [Person] = [Person(name: "*Zay", title: "Zay执行总裁", avatar: "2"), Person(name: "May", title: "Goolge CEO", avatar: "1"), Person(name: "马云", title: "阿里巴巴董事长", avatar: "1"), Person(name: "马戏", title: "淘宝董事长", avatar: "3"), Person(name: "刘强东", title: "京东商城CEO", avatar: "2"), Person(name: "罗洪鹏", title: "蜂助手CEO", avatar: "3"), Person(name: "360周鸿祎", title: "360CEO", avatar: "2")]
        seedPerson.forEach { (person) -> () in
            let hanyu = PinyinHelper.toHanyuPinyinStringWithNSString(person.name, withHanyuPinyinOutputFormat: HanyuFormat, withNSString: " ")
            var key = hanyu.substringToIndex(hanyu.startIndex.successor())
            switch key {
            case "A"..."Z":
                break
            default:
                key = "#"
            }
            SD.executeChange("INSERT INTO Contacts (Key, Pinyin, Name, Title, AvatarUrl, Relationship) VALUES (?, ?, ?, ?, ?, ?) ", withArgs: [key, hanyu, person.name, person.title, person.avatar, RelationshipType.Friend.rawValue])
        }
    }
    
    func fetchPersons(key: String? = nil) -> [Person]? {
        var result: (result: [SwiftData.SDRow], error: Int?)?
        if key != nil {
            result = SD.executeQuery("SELECT * FROM Contacts WHERE Key = ? AND Relationship = ?", withArgs: [key!, RelationshipType.Friend.rawValue])
        } else {
            result = SD.executeQuery("SELECT * FROM Contacts WHERE Relationship = ?", withArgs: [RelationshipType.Friend.rawValue])
        }
        if result?.error == nil {
            var persons = [Person]()
            result?.result.forEach({ (row) -> () in
                let name = row["Name"]?.asString()
                let title = row["Title"]?.asString()
                let avatar = row["AvatarUrl"]?.asString()
                let person = Person(name: name!, title: title!, avatar: avatar!)
                person.pinyin = row["Pinyin"]?.asString()
                persons.append(person)
            })
            return persons.sort({ (left, right) -> Bool in
                return left.pinyin <= right.pinyin
            })
        }
        return nil
    }
}
