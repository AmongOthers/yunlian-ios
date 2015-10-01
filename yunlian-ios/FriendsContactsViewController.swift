//
//  FriendsContactsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/18.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class FriendsContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct UX {
        static let HeightForHeader:CGFloat = 26.5
        static let HeightForRow:CGFloat = 59
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    
    var tableView: UITableView!
    let sections: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
    
    var query = PersonsQuery()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        tableView.backgroundColor = UIConstants.BackgroundGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FriendsContactCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.registerClass(FriendsContactHeader.self, forHeaderFooterViewReuseIdentifier: HeaderIdentifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return query.count(sections[section])
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! FriendsContactCell
        let index = indexPath.item
        let data = query.lookUp(sections[indexPath.section])
        if data?.count > 0 {
            cell.nameLabel.text = data?[index].name
            cell.titleLabel.text = data?[index].title
            cell.avatarView.image = data?[index].image
            if(index == data!.count - 1) {
                cell.isLastCell = true
            } else {
                cell.isLastCell = false
            }    
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let count = query.count(sections[section])
        if count > 0 {
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderIdentifier) as? FriendsContactHeader
            header?.label.text = sections[section]
            return header
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let count = query.count(sections[section])
        if count > 0 {
            return UX.HeightForHeader
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.HeightForRow
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.setSelected(false, animated: true)
        let controller = ProfileViewController()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() {
        
    }
}
