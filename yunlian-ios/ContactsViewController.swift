//
//  ContactsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    private struct UX {
        static let HeaderHeight:CGFloat = 37.5
        static let BackGroundColor = UIColor(rgb: 0xebedf0)
        static let TopOffset = 8
        static let HeaderInternalOffset = 16
    }
    
    var friendsHeader: ContactsHeaderView!
    var onewayHeader: ContactsHeaderView!
    var blacklistHeader: ContactsHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UX.BackGroundColor
        friendsHeader = ContactsHeaderView(title: "我的联系人", isUpSideDown: false)
        view.addSubview(friendsHeader)
        friendsHeader.backgroundColor = UIColor.whiteColor()
        onewayHeader = ContactsHeaderView(title: "单向关注", isUpSideDown: true)
        view.addSubview(onewayHeader)
        onewayHeader.backgroundColor = UIColor.whiteColor()
        blacklistHeader = ContactsHeaderView(title: "黑名单", isUpSideDown: true)
        view.addSubview(blacklistHeader)
        blacklistHeader.backgroundColor = UIColor.whiteColor()
        setupConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        friendsHeader.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.width.equalTo(self.view)
            make.height.equalTo(UX.HeaderHeight)
        }
        onewayHeader.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.friendsHeader.snp_bottom).offset(UX.HeaderInternalOffset)
            make.width.equalTo(self.view)
            make.height.equalTo(UX.HeaderHeight)
        }
        blacklistHeader.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.onewayHeader.snp_bottom).offset(UX.HeaderInternalOffset)
            make.width.equalTo(self.view)
            make.height.equalTo(UX.HeaderHeight)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
