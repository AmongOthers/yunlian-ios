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
    var isBarHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        automaticallyAdjustsScrollViewInsets = false
        
        let fileManager = NSFileManager()
        let path = ((NSURL(string: NSHomeDirectory())?.URLByAppendingPathComponent("Documents"))?.path)!
        fileManager.enumeratorAtPath(path)?.forEach({ (fileName) -> () in
            let imagePath = (NSURL(string: path)?.URLByAppendingPathComponent(fileName as! String).path)!
            let image = UIImage(data: fileManager.contentsAtPath(imagePath)!)!
            self.images.append(image)
        })
        photoScrollView = PhotoScrollView(frame: view.frame, imageArray: images, currentPageNumber: 0)
        view.addSubview(photoScrollView)
        photoScrollView.photoDelegate = self
        title = "\(1)/\(images.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TestViewController: PhotoDelegate {
    func tapped() {
        if isBarHidden {
            isBarHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
            
        } else {
            isBarHidden = true
            navigationController?.setNavigationBarHidden(true, animated: true)
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        }
    }
}