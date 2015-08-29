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

        static let TopOffset:CGFloat = 8
        static let HeaderInternalOffset:CGFloat = 16
        static let HeaderInternalOffsetShrink:CGFloat = 2
        static let PanelWidth = 105
        static let PanelHeight = 100
        static let PanelRightOffset = 4
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
    var panel: ContactsPanelView!
    var wrapPanelView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConstants.BackgroundGray
        
        let searchItem = UIBarButtonItem(image: UIImage(named: "searchItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "searchTapped")
        let addItem = UIBarButtonItem(image: UIImage(named: "addItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped")
        self.navigationItem.rightBarButtonItems = [addItem, searchItem]
        
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
        
        //点击其他区域，让panel消失
        wrapPanelView = UIView()
        view.addSubview(wrapPanelView)
        wrapPanelView.backgroundColor = UIColor.clearColor()
        wrapPanelView.hidden = true
        wrapPanelView.userInteractionEnabled = true
        wrapPanelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "panelOutsideTapped"))
        
        panel = ContactsPanelView()
        wrapPanelView.addSubview(panel)
        panel.alpha = 0
        
        setupConstraints()
    }
    
    func panelOutsideTapped() {
        addTapped()
    }
    
    func searchTapped() {
//        let screenshot = UIScreen.mainScreen().snapshotViewAfterScreenUpdates(true)
        let image = UIImage(UIView: navigationController?.parentViewController?.view, andRect: CGRectMake(0, 64, view.frame.width, view.frame.height))
        let searchController = SearchContactsViewController()
        searchController.backgroundImage = image
        searchController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchController, animated: false)
//        let controller = UINavigationController(rootViewController: searchController)
//        presentViewController(controller, animated: false) { () -> Void in
//        }
    }
    
    func addTapped() {
        if wrapPanelView.hidden {
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
                self.panel.alpha = 1
                }, completion: { (finished) -> Void in
                    if finished {
                        self.wrapPanelView.hidden = false
                    }
            })
        } else {
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
                self.panel.alpha = 0
                }, completion: { (finished) -> Void in
                    if finished {
                        self.wrapPanelView.hidden = true
                    }
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if !wrapPanelView.hidden {
            self.panel.alpha = 0
            wrapPanelView.hidden = true
        }
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
    
    func setupConstraints() {
        wrapPanelView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
            make.left.right.equalTo(view)
        }
        panel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.wrapPanelView)
            make.width.equalTo(UX.PanelWidth)
            make.height.equalTo(UX.PanelHeight)
            make.right.equalTo(self.wrapPanelView).offset(-UX.PanelRightOffset)
        }
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
                make.height.equalTo(0)
            })
            onewayController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(onewayHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
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
                make.height.equalTo(0)
            })
            blackListController?.view.snp_remakeConstraints(closure: { (make) -> Void in
                make.width.equalTo(view)
                make.top.equalTo(blacklistHeader.snp_bottom).offset(UX.HeaderInternalOffsetShrink)
                make.height.equalTo(0)
            })
            break
        }
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
