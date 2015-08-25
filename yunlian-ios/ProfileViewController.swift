//
//  ProfileViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/23.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, ProfileHeaderViewDelegate {
    
    struct UX {
        static let HeaderHeight:CGFloat = 85
        static let PanelSize:CGFloat = 200
        static let QrCodeSize:CGFloat = 140
        static let QrCodeMinSize:CGFloat = 10
        static let QrCodePanelRightOffset:CGFloat = 30
        static let QrCodePanelTopOffset:CGFloat = 10
    }
    
    var toolbar: UIToolbar!
    var headerView: ProfileHeaderView!
    var qrCodePanel: UIView!
    var qrCodeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详细信息"
        self.view.backgroundColor = UIConstants.BackgroundGray
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
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        headerView = ProfileHeaderView()
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        
        qrCodePanel = UIView()
        view.addSubview(qrCodePanel)
        qrCodePanel.backgroundColor = UIColor.whiteColor()
        qrCodePanel.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        qrCodePanel.layer.shadowColor = UIConstants.FirstGray.CGColor
        qrCodePanel.layer.shadowOpacity = 1
        qrCodeImageView = UIImageView()
        qrCodePanel.addSubview(qrCodeImageView)
        qrCodeImageView.image = UIImage(named: "qrdemo")
        qrCodeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        qrCodePanel.hidden = true
    }
    
    func audioTapped() {
    }
    
    func pictureTapped() {
        
    }
    
    func videoTapped() {
        
    }
    
    func moreTapped() {
        
    }
    
    func qrCodeTapped() {
        if qrCodePanel.hidden {
            qrCodePanel.hidden = false
            qrCodePanel.snp_remakeConstraints { (make) -> Void in
                make.width.height.equalTo(UX.PanelSize)
                make.right.equalTo(self.headerView).offset(-UX.QrCodePanelRightOffset)
                make.top.equalTo(self.headerView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
            }
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                self.qrCodePanel.layoutIfNeeded()
//            })
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.qrCodePanel.layoutIfNeeded()
                }, completion: { _ -> Void in
                    
            })
        } else {
            qrCodePanel.snp_remakeConstraints { (make) -> Void in
                make.width.height.equalTo(UX.QrCodeMinSize)
                make.right.equalTo(self.headerView).offset(-UX.QrCodePanelRightOffset)
                make.top.equalTo(self.headerView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
            }
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
                self.qrCodePanel.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    if finished {
                        self.qrCodePanel.hidden = true
                    }
            })
        }
    }
    
    func setupConstraints() {
        toolbar.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.snp_bottomLayoutGuideBottom)
        }
        headerView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(UX.HeaderHeight)
        }
        qrCodePanel.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.QrCodeMinSize)
            make.right.equalTo(self.headerView).offset(-UX.QrCodePanelRightOffset)
            make.top.equalTo(self.headerView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
        }
        qrCodeImageView.snp_remakeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.qrCodePanel)
            make.width.height.equalTo(self.qrCodePanel).multipliedBy(0.7)
        }
    }
}
