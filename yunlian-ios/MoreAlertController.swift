//
//  MoreAlertController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/21.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class MoreAlertController: UIAlertController {
    
    struct UX {
        static let LineHeight: CGFloat = 57
        static let SideOffset: CGFloat = 8
    }
    
    var tableView: UITableView!
    let CellIdentifier = "CellIdentifier"
    let actionTexts = ["名片分享", "拉入黑名单", "删除"]
    let actionIcons = ["share", "blacklist", "delete"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        view.tintColor = UIConstants.TintColor
        view.snp_remakeConstraints { (make) -> Void in
            make.height.equalTo(UX.LineHeight * 3 + UIConstants.AlertCancelButtonHeight)
        }
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(1)
            make.height.equalTo(UX.LineHeight * 3 - 2)
            make.left.equalTo(view).offset(UX.SideOffset)
            make.right.equalTo(view).offset(-UX.SideOffset)
        }
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MoreAlertCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
    }
}

extension MoreAlertController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.LineHeight
    }
}

extension MoreAlertController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! MoreAlertCell
        cell.actionLabel.text = actionTexts[indexPath.row]
        cell.actionIcon.image = UIImage(named: actionIcons[indexPath.row])
        if indexPath.row == 2 {
            cell.isLastCell = true
        } else {
            cell.isLastCell = false
        }
        return cell
    }
}