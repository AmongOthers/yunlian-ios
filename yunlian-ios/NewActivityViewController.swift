//
//  NewActivityViewController.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController {
    
    struct UX {
        static let TopOffset: CGFloat = 8
        static let HeaderHeight: CGFloat = 14
        static let RowHeight: CGFloat = 40
        static let InviteRowHight: CGFloat = 44
        static let RemarkRowHeight: CGFloat = 120
        static let ButtonRowHeight: CGFloat = 68
    }
    
    var tableView: UITableView!
    
    static let CellIdentifier = "CellIdentifier"
    static let TextCellIdentifier = "TextCellIdentifier"
    static let TimeCellIdentifier = "TimeCellIdentifier"
    static let TimespanCellIdentifier = "TimespanCellIdentifier"
    static let InviteCellIdentifier = "InviteCellIdentifier"
    static let RemindCellIdentifier = "RemindCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        title = "新建日程"
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIConstants.BackgroundGray
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        tableView.registerClass(ActivityBaseCell.self, forCellReuseIdentifier: NewActivityViewController.CellIdentifier)
        tableView.registerClass(ActivityTextCell.self, forCellReuseIdentifier: NewActivityViewController.TextCellIdentifier)
        tableView.registerClass(ActivityTimeCell.self, forCellReuseIdentifier: NewActivityViewController.TimeCellIdentifier)
        tableView.registerClass(ActivityTimespanCell.self, forCellReuseIdentifier: NewActivityViewController.TimespanCellIdentifier)
        tableView.registerClass(ActivityInviteCell.self, forCellReuseIdentifier: NewActivityViewController.InviteCellIdentifier)
        tableView.registerClass(ActivityRemindCell.self, forCellReuseIdentifier: NewActivityViewController.RemindCellIdentifier)
    }
    
    func setupConstraints() {
        tableView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.right.left.bottom.equalTo(view)
        }
    }

}

extension NewActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ActivityBaseCell!
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            cell = tableView.dequeueReusableCellWithIdentifier(NewActivityViewController.TextCellIdentifier) as! ActivityBaseCell
            break
        case (1, 2):
            cell = tableView.dequeueReusableCellWithIdentifier(NewActivityViewController.TimespanCellIdentifier) as! ActivityTimespanCell
            break
        case (1, _):
            cell = tableView.dequeueReusableCellWithIdentifier(NewActivityViewController.TimeCellIdentifier) as! ActivityTimeCell
            break
        case (2, _):
            cell = tableView.dequeueReusableCellWithIdentifier(NewActivityViewController.InviteCellIdentifier) as! ActivityInviteCell
            break
        case (3, _):
            cell = tableView.dequeueReusableCellWithIdentifier(NewActivityViewController.RemindCellIdentifier) as! ActivityRemindCell
            break
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(NewActivityViewController.CellIdentifier) as! ActivityBaseCell
        }
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.label.text = "标题"
            break
        case (0, 1):
            cell.label.text = "地点"
            break
        case (1, 0):
            cell.label.text = "开始时间"
            break
        case (1, 1):
            cell.label.text = "结束时间"
            break
        case (1, 2):
            cell.label.text = "用时"
            break
        case (2, 0):
            cell.label.text = "被邀请人"
            break
        case (3, 0):
            cell.label.text = "提醒"
            break
        case (4, 0):
            cell.label.text = "备注"
            break
        default:
            break
        }
        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            cell.seperatorView.hidden = true
            break
        case (1, 2):
            cell.seperatorView.hidden = true
            break
        case (let x, _) where x != 0 && x != 1:
            cell.seperatorView.hidden = true
            break
        default:
            cell.seperatorView.hidden = false
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return UX.HeaderHeight
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return UX.InviteRowHight
        case 4:
            return UX.RemarkRowHeight
        case 5:
            return UX.ButtonRowHeight
        default:
            return UX.RowHeight
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}
