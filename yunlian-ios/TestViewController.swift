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
        
        let result = "{\"isSucessed\":true,\"info\":\"登录成功\",\"result\":{\"userId\":\"1\"}}"
        print(NSData.AES256EncryptWithPlainText(result))
        
        login("15102053276", password: "123456")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func deleteTapped() {
        //let isLast = photoScrollView.currentPageNumber == images.count - 1
        photoScrollView.deleteCurrentPage()
    }
    
    func login(phoneNumber: String, password: String) {
        let parameters = ["phoneNumber":phoneNumber, "password":password]
        YunlianNetwork.yunlianRequest(.Login, parameters: parameters) { result -> Void in
            print(result)
        }
    }
}

extension TestViewController: PhotoScrollViewDelegate {
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