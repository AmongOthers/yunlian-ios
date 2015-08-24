//
//  ProfileViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/23.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详细信息"
        self.view.backgroundColor = UIColor.whiteColor()
        setupViews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupViews() {
        let audioItem = UIBarButtonItem(image: UIImage(named: "audioItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "audioTapped")
        let pictureItem = UIBarButtonItem(image: UIImage(named: "pictureItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "pictureItem")
        let videoItem = UIBarButtonItem(image: UIImage(named: "videoItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "videoItem")
        let moreItem = UIBarButtonItem(image: UIImage(named: "moreItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "moreTapped")
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolbar = UIToolbar()
        view.addSubview(toolbar)
        toolbar.items = [audioItem, flex, pictureItem, flex, videoItem, flex, moreItem]
        toolbar.tintColor = UIConstants.TintColor
    }
    
    func audioTapped() {
    }
    
    func pictureTapped() {
        
    }
    
    func videoTapped() {
        
    }
    
    func moreTapped() {
        
    }
    
    func setupConstraints() {
        toolbar.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.snp_bottomLayoutGuideBottom)
        }
    }
}
