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

class ContactsViewController: UIViewController, ContactsHeaderViewDelegate {
    private struct UX {
        static let HeaderHeight:CGFloat = 37.5
        static let BackGroundColor = UIColor(rgb: 0xebedf0)
        static let TopOffset:CGFloat = 8
        static let HeaderInternalOffset:CGFloat = 16
        static let HeaderInternalOffsetShrink:CGFloat = 2
        static let TableHeightSubset:CGFloat = UX.TopOffset + 3 * UX.HeaderHeight + 3 * UX.HeaderInternalOffsetShrink + 64 + 44 + 10 //加上偏移量让黑名单标题不要离uitabbar太近
    }
    
    var friendsHeader: ContactsHeaderView!
    var onewayHeader: ContactsHeaderView!
    var blacklistHeader: ContactsHeaderView!
    var friendsController: FriendsContactsViewController?
    var onewayController: OnewayContactsViewController?
    var blackListController: BlackListContactsViewController?
    var tableHeight:CGFloat = 0
    var width:CGFloat = 0
    var preState: ContactsViewControllerState? = nil
    var state = ContactsViewControllerState.Friends

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UX.BackGroundColor
        
        friendsHeader = ContactsHeaderView(title: "我的联系人", isOpen: true, state: .Friends)
        friendsHeader.delegate = self
        view.addSubview(friendsHeader)
        friendsHeader.backgroundColor = UIColor.whiteColor()
        
        onewayHeader = ContactsHeaderView(title: "单向关注", isOpen: false, state: .Oneway)
        onewayHeader.delegate = self
        view.addSubview(onewayHeader)
        onewayHeader.backgroundColor = UIColor.whiteColor()
        
        blacklistHeader = ContactsHeaderView(title: "黑名单", isOpen: false, state: .Blacklist)
        blacklistHeader.delegate = self
        view.addSubview(blacklistHeader)
        blacklistHeader.backgroundColor = UIColor.whiteColor()
        
        friendsController = FriendsContactsViewController()
        addChildViewController(friendsController!)
        view.addSubview(friendsController!.view)
        friendsController?.didMoveToParentViewController(self)
        
        onewayController = OnewayContactsViewController()
        addChildViewController(onewayController!)
        view.addSubview(onewayController!.view)
        onewayController?.didMoveToParentViewController(self)
        
        blackListController = BlackListContactsViewController()
        addChildViewController(blackListController!)
        view.addSubview(blackListController!.view)
        blackListController?.didMoveToParentViewController(self)
        
        setupConstraints()
    }
    
    
    func headerTapped(header: ContactsHeaderView) {
        let tappedState = header.state
        if state != tappedState {
            changeContactsController(state, newState: tappedState)
        } else {
            if preState == nil {
                preState = .Oneway
            }
            changeContactsController(state, newState: preState!)
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        friendsHeader.snp_removeConstraints()
        onewayHeader.snp_removeConstraints()
        blacklistHeader.snp_removeConstraints()
        friendsController?.view.snp_removeConstraints()
        onewayController?.view.snp_removeConstraints()
        blackListController?.view.snp_removeConstraints()
        setupConstraints()
    }
    
//    override func viewDidLayoutSubviews() {
//        setupLayout()
//    }
    
    func setupConstraints() {
        friendsHeader.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(UX.HeaderHeight)
            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(UX.TopOffset)
        }
        switch state {
        case .Oneway:
            onewayHeader.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.height.equalTo(UX.HeaderHeight)
                make.top.equalTo(friendsHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
            })
            blacklistHeader.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.height.equalTo(UX.HeaderHeight)
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop).offset(-UX.HeaderInternalOffsetShrink)
            })
            friendsController!.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(friendsHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
//                make.bottom.equalTo(onewayHeader.snp_top).offset(-UX.HeaderInternalOffset)
                make.height.equalTo(0)
            })
            onewayController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(onewayHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
                make.bottom.equalTo(blacklistHeader.snp_top).offset(-UX.HeaderInternalOffset)
            })
            blackListController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(blacklistHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
                //                make.bottom.equalTo(self.snp_bottomLayoutGuideTop).offset(-UX.HeaderInternalOffset)
                make.height.equalTo(0)
            })
            break
        case .Blacklist:
            onewayHeader.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.height.equalTo(UX.HeaderHeight)
                make.top.equalTo(friendsHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
            })
            blacklistHeader.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.height.equalTo(UX.HeaderHeight)
                make.top.equalTo(onewayHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
            })
            friendsController!.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(friendsHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
//                make.bottom.equalTo(onewayHeader.snp_top).offset(-UX.HeaderInternalOffset)
                make.height.equalTo(0)
            })
            onewayController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(onewayHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
                //                make.bottom.equalTo(blacklistHeader.snp_top).offset(-UX.HeaderInternalOffset)
                make.height.equalTo(0)
            })
            blackListController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(blacklistHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop).offset(-UX.HeaderInternalOffset)
            })
            break
        default:
            blacklistHeader.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.height.equalTo(UX.HeaderHeight)
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop).offset(-UX.HeaderInternalOffsetShrink)
            })
            onewayHeader.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.height.equalTo(UX.HeaderHeight)
                make.bottom.equalTo(blacklistHeader.snp_top).offset(-UX.HeaderInternalOffsetShrink)
            })
            friendsController!.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(friendsHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
                make.bottom.equalTo(onewayHeader.snp_top).offset(-UX.HeaderInternalOffset)
            })
            onewayController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(onewayHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
//                make.bottom.equalTo(blacklistHeader.snp_top).offset(-UX.HeaderInternalOffset)
                make.height.equalTo(0)
            })
            blackListController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(blacklistHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
//                make.bottom.equalTo(self.snp_bottomLayoutGuideTop).offset(-UX.HeaderInternalOffset)
                make.height.equalTo(0)
            })
            break
        }
    }
    
    func setupLayout() {
        //我的联系人这个标题栏时固定的
        friendsHeader.frame = CGRectMake(0, UX.TopOffset, width, UX.HeaderHeight)
        switch state {
        case .Oneway:
            friendsController!.view.frame = zeroChildControllerViewRect(friendsHeader)
            onewayHeader.frame = friendsHeader.frame.rectByOffsetting(dx: 0, dy: UX.HeaderHeight + UX.HeaderInternalOffsetShrink)
            onewayController!.view.frame = CGRectMake(0, onewayHeader.frame.origin.y + UX.HeaderHeight + UX.HeaderInternalOffsetShrink, width, tableHeight - UX.HeaderInternalOffset)
            blacklistHeader.frame = CGRectMake(0, onewayHeader.frame.origin.y + UX.HeaderHeight + tableHeight, width, UX.HeaderHeight)
            blackListController!.view.frame = zeroChildControllerViewRect(blacklistHeader)
        case .Blacklist:
            friendsController!.view.frame = zeroChildControllerViewRect(friendsHeader)
            onewayHeader.frame = friendsHeader.frame.rectByOffsetting(dx: 0, dy: UX.HeaderHeight + UX.HeaderInternalOffsetShrink)
            onewayController!.view.frame = zeroChildControllerViewRect(onewayHeader)
            blacklistHeader.frame = onewayHeader.frame.rectByOffsetting(dx: 0, dy: UX.HeaderHeight + UX.HeaderInternalOffsetShrink)
            blackListController!.view.frame = CGRectMake(0, blacklistHeader.frame.origin.y + UX.HeaderHeight + UX.HeaderInternalOffsetShrink, width, tableHeight)
            break
        default:
            friendsController!.view.frame = CGRectMake(0, friendsHeader.frame.origin.y + UX.HeaderHeight + UX.HeaderInternalOffsetShrink, width, tableHeight - UX.HeaderInternalOffset)
            onewayHeader.frame = friendsHeader.frame.rectByOffsetting(dx: 0, dy: UX.HeaderHeight + tableHeight)
            onewayController!.view.frame = zeroChildControllerViewRect(onewayHeader)
            blacklistHeader.frame = onewayHeader.frame.rectByOffsetting(dx: 0, dy: UX.HeaderHeight + UX.HeaderInternalOffsetShrink)
            blackListController!.view.frame = zeroChildControllerViewRect(blacklistHeader)
            break
        }
    }
    
    func zeroChildControllerViewRect(header: ContactsHeaderView) -> CGRect {
        return CGRectMake(0, header.frame.origin.y + UX.HeaderHeight + UX.HeaderInternalOffsetShrink, width, 0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeContactsController(oldState: ContactsViewControllerState, newState: ContactsViewControllerState) {
        var openingHeader: ContactsHeaderView!
        var closingHeader: ContactsHeaderView!
        var openingController: UIViewController!
        var closingController: UIViewController!
        switch oldState {
        case .Oneway:
            closingHeader = onewayHeader
            closingController = onewayController
            break
        case .Blacklist:
            closingHeader = blacklistHeader
            closingController = blackListController
            break
        default:
            closingHeader = friendsHeader
            closingController = friendsController
            break
        }
        switch newState {
        case .Oneway:
            openingHeader = onewayHeader
            openingController = onewayController
            break
        case .Blacklist:
            openingHeader = blacklistHeader
            openingController = blackListController
            break
        default:
            openingHeader = friendsHeader
            openingController = friendsController
            break
        }
        openingHeader.open()
        closingHeader.close()
        preState = oldState
        state = newState
        view.setNeedsUpdateConstraints()
    }
}
