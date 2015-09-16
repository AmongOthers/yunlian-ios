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
    var isBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(imageIndex + 1)/\(images!.count)"
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.blackColor()
        photoScrollView = PhotoScrollView(frame: view.frame, imageArray: images!, currentPageNumber: imageIndex)
        view.addSubview(photoScrollView)
        photoScrollView.photoDelegate = self
        
        let deleteItem = UIBarButtonItem(image: UIImage(named: "delete"), style: UIBarButtonItemStyle.Plain, target: self, action: "deleteTapped")
        navigationItem.rightBarButtonItem = deleteItem
    }
    
    func deleteTapped() {
        if photoScrollView.imageArray?.count == 1 {
            navigationController?.popViewControllerAnimated(true)
        } else {
            photoScrollView.deleteCurrentPage()
        }
    }

}

extension ImageBrowserController: PhotoScrollViewDelegate {
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
    
    func pageChanged(current: Int, total: Int) {
        title = "\(current + 1)/\(total)"
    }
}