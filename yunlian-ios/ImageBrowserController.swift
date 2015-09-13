//
//  ImageBrowserController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/13.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ImageBrowserController: UIViewController {
    
    var images: [UIImage]?
    var imageIndex: Int = 0
    var photoScrollView: PhotoScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(imageIndex + 1)/\(images?.count)"
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.blackColor()
        photoScrollView = PhotoScrollView(frame: view.frame, imageArray: images!, currentPageNumber: imageIndex)
        view.addSubview(photoScrollView)
    }

}
