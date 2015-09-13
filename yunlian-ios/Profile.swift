//
//  Profile.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/13.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import Foundation

class Profile {
    var images = [UIImage]()
    var pendingImages = [UIImage]()
    var index = 0
    
    init() {
        let fileManager = NSFileManager()
        let path = ((NSURL(string: NSHomeDirectory())?.URLByAppendingPathComponent("Documents"))?.path)!
        fileManager.enumeratorAtPath(path)?.forEach({ (fileName) -> () in
            let imagePath = (NSURL(string: path)?.URLByAppendingPathComponent(fileName as! String).path)!
            let image = UIImage(data: fileManager.contentsAtPath(imagePath)!)!
            self.pendingImages.append(image)
        })
    }
    
    func addImage() {
        if index < pendingImages.count {
            images.append(pendingImages[index++])
        }
    }
}