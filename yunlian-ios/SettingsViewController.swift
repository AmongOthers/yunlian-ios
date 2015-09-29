//
//  SettingsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    struct UX {
        static let HeaderHeight:CGFloat = 85
        static let PanelSize:CGFloat = 200
        static let QrCodeSize:CGFloat = 140
        static let QrCodeMinSize:CGFloat = 10
        static let QrCodePanelRightOffset:CGFloat = 30
        static let QrCodePanelTopOffset:CGFloat = 10
        static let HeightForHeader:CGFloat = 43.5
        static let HeightForRow:CGFloat = 34
        static let VInsetForImageCell: CGFloat = 14.5
        static let HeightForSignatureRow: CGFloat = 68
        static let HeightForSettingRow: CGFloat = 45
        static let HeightForButtonsRow: CGFloat = 128
        static let HeaderTitles = ["个性签名", "联系信息", "设置"]
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    let RemarkHeaderIdentifier = "RemarkHeaderIdentifier"
    let SignatureCellIdentifier = "SignatureCellIdentifier"
    let ButtonsCellIdentifier = "ButtonsCellIdentifier"
    
    var toolbar: UIToolbar!
    var tableView: UITableView!
    var headerView: ProfileHeaderView!
    var panelMask: UIView!
    var qrCodePanel: UIView!
    var qrCodeImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        title = "我的"
        view.backgroundColor = UIConstants.BackgroundGray
        automaticallyAdjustsScrollViewInsets = false
        
        let editItem = UIBarButtonItem(image: UIImage(named: "edit"), style: UIBarButtonItemStyle.Plain, target: self, action: "editTapped")
        navigationItem.rightBarButtonItem = editItem
        
        headerView = ProfileHeaderView()
        headerView.delegate = self
        view.addSubview(headerView)
        
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(ProfileCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.registerClass(ProfileSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderIdentifier)
        tableView.registerClass(ProfileRemarkSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: RemarkHeaderIdentifier)
        tableView.registerClass(SignatureCell.self, forCellReuseIdentifier: SignatureCellIdentifier)
        tableView.registerClass(SettingsButtonCell.self, forCellReuseIdentifier: ButtonsCellIdentifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.bounces = false
        tableView.backgroundColor = UIConstants.BackgroundGray
        
        let tuple = Helper.panelView(view, target: self, action: "maskTapped")
        panelMask = tuple.mask
        qrCodePanel = tuple.panel
        qrCodePanel.backgroundColor = UIColor.whiteColor()
        qrCodePanel.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        qrCodePanel.layer.shadowColor = UIConstants.FirstGray.CGColor
        qrCodePanel.layer.shadowOpacity = 1
        qrCodeImageView = UIImageView()
        qrCodePanel.addSubview(qrCodeImageView)
        qrCodeImageView.image = UIImage(named: "qrdemo")
        qrCodeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        panelMask.hidden = true
        qrCodePanel.hidden = true
    }
    
    func setupConstraints() {
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
        tableView.snp_remakeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.headerView.snp_bottom)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
    }
    
    func maskTapped() {
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
                    self.panelMask.hidden = true
                }
        })
    }
    
    func editTapped() {
        navigationController?.pushViewController(ModifyInfoViewController(), animated: true)
    }
}

extension SettingsViewController: ProfileHeaderViewDelegate {
    func qrCodeTapped() {
        if qrCodePanel.hidden {
            view.bringSubviewToFront(panelMask)
            panelMask.hidden = false
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
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return UX.HeaderTitles.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 7
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier(SignatureCellIdentifier) as! SignatureCell
        case 3:
            return tableView.dequeueReusableCellWithIdentifier(ButtonsCellIdentifier) as! SettingsButtonCell
        default:
            return tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! ProfileCell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case let i where i < 3:
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderIdentifier) as? ProfileSectionHeaderView
            header?.titleLabel.text = UX.HeaderTitles[section]
            return header
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 3 {
            return UX.HeightForHeader
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UX.HeightForSignatureRow
        case 2:
            return UX.HeightForSettingRow
        case 3:
            return UX.HeightForButtonsRow
        default:
            return UX.HeightForRow
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}