//
//  ContactsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

enum ContactsViewControllerState {
    case Friends
    case Oneway
    case Blacklist
}

class ContactsViewController: UIViewController {
    private struct UX {
        static let HeaderHeight:CGFloat = 37.5
        static let BackGroundColor = UIColor(rgb: 0xebedf0)
        static let TopOffset = 8
        static let HeaderInternalOffset = 16
        static let HeaderInternalOffsetShrink = 2
    }
    
    var state: ContactsViewControllerState = ContactsViewControllerState.Friends
    var friendsHeader: ContactsHeaderView!
    var onewayHeader: ContactsHeaderView!
    var blacklistHeader: ContactsHeaderView!
    var friendsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UX.BackGroundColor
        friendsHeader = ContactsHeaderView(title: "我的联系人", isOpen: true)
        view.addSubview(friendsHeader)
        friendsHeader.backgroundColor = UIColor.whiteColor()
        onewayHeader = ContactsHeaderView(title: "单向关注", isOpen: false)
        view.addSubview(onewayHeader)
        onewayHeader.backgroundColor = UIColor.whiteColor()
        blacklistHeader = ContactsHeaderView(title: "黑名单", isOpen: false)
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
        if(state == .Friends) {
            blacklistHeader.snp_remakeConstraints { (make) -> Void in
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
                make.width.equalTo(self.view)
                make.height.equalTo(UX.HeaderHeight)
            }
            onewayHeader.snp_remakeConstraints { (make) -> Void in
                make.bottom.equalTo(self.blacklistHeader.snp_top).offset(-UX.HeaderInternalOffsetShrink)
                make.width.equalTo(self.view)
                make.height.equalTo(UX.HeaderHeight)
            }
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
