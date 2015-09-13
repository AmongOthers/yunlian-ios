//
//  ProfileViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/23.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
        static let HeaderTitles = ["个性签名", "联系信息", "其他信息", "备注", "文字备忘", "图片备忘", "录像备忘", "语音备忘"]
        static var ImageCellSize: CGSize?
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    let RemarkHeaderIdentifier = "RemarkHeaderIdentifier"
    let SignatureCellIdentifier = "SignatureCellIdentifier"
    let ImageRemarkCellIdentifier = "ImageRemarkCellIdentifier"
    
    var toolbar: UIToolbar!
    var tableView: UITableView!
    var headerView: ProfileHeaderView!
    var panelMask: UIView!
    var qrCodePanel: UIView!
    var qrCodeImageView: UIImageView!
    
    var profile: Profile!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详细信息"
        self.view.backgroundColor = UIConstants.BackgroundGray
        profile = Profile()
        UX.ImageCellSize = calculateImageCellItemSize()
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
        
        headerView = ProfileHeaderView()
        headerView.delegate = self
        headerView.frame = CGRectMake(0, 0, view.frame.size.width, UX.HeaderHeight)
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
        tableView.registerClass(ImageRemarkCell.self, forCellReuseIdentifier: ImageRemarkCellIdentifier)
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
    
    func audioTapped() {
    }
    
    func pictureTapped() {
        
    }
    
    func videoTapped() {
        
    }
    
    func moreTapped() {
        
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
    
    func setupConstraints() {
        toolbar.snp_remakeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.snp_bottomLayoutGuideBottom)
        }
//        headerView.snp_remakeConstraints { (make) -> Void in
//            make.top.equalTo(self.snp_topLayoutGuideBottom)
//            make.left.equalTo(self.view)
//            make.right.equalTo(self.view)
//            make.width.equalTo(self.view)
//            make.height.equalTo(UX.HeaderHeight)
//        }
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
            make.bottom.equalTo(self.toolbar.snp_top)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return UX.HeaderTitles.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier(SignatureCellIdentifier) as! SignatureCell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier(ImageRemarkCellIdentifier) as! ImageRemarkCell
            cell.delegate = self
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! ProfileCell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case let i where i > 3:
                let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(RemarkHeaderIdentifier) as? ProfileRemarkSectionHeaderView
                header?.titleLabel.text = UX.HeaderTitles[section]
                return header
        default:
                let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderIdentifier) as? ProfileSectionHeaderView
                header?.titleLabel.text = UX.HeaderTitles[section]
                return header
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UX.HeightForHeader
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UX.HeightForSignatureRow
        case 5:
            return calculateImageRemarkRowHeight()
        default:
            return UX.HeightForRow
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func calculateImageRemarkRowHeight() -> CGFloat {
        let n = numberOfCells()
        let size = (UX.ImageCellSize)!
        return  (n >= 4 ? 3 : 2) * UX.VInsetForImageCell + (n >= 4 ? 2 : 1) * size.height
    }
    
    func calculateImageCellItemSize() -> CGSize {
        let frameWidth = view.frame.width
        let size = CGSizeMake(frameWidth / 320 * 56.5, frameWidth / 320 * 50)
        return size
    }
}

extension ProfileViewController: ImageRemarkCellDelegate {
    func numberOfCells() -> Int {
        return profile.images.count
    }
    
    func images() -> [UIImage] {
        return profile.images
    }
    
    func addImageTapped(sender: ImageRemarkCell) {
        profile.addImage()
        sender.imageCollectionView.reloadData()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
