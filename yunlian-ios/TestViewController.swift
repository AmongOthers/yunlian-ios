//
//  TestViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/22.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    var photoScrollView: PhotoScrollView!
    var images = [UIImage]()
    var offsetUnit: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = true
        automaticallyAdjustsScrollViewInsets = false
        
        let fileManager = NSFileManager()
        let path = ((NSURL(string: NSHomeDirectory())?.URLByAppendingPathComponent("Documents"))?.path)!
        fileManager.enumeratorAtPath(path)?.forEach({ (fileName) -> () in
            let imagePath = (NSURL(string: path)?.URLByAppendingPathComponent(fileName as! String).path)!
            let image = UIImage(data: fileManager.contentsAtPath(imagePath)!)!
            self.images.append(image)
        })
        let hackFrame = CGRectMake(0, 0, view.frame.width + PhotoScrollView.UX.PhotoGap, view.frame.height)
        photoScrollView = PhotoScrollView(frame: hackFrame, imageArray: images, currentPageNumber: 2)
        view.addSubview(photoScrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}