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
    var data = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "1"))
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "2"))
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "3"))
        
//         Do any additional setup after loading the view.
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
        //首字母+其他（数字和其他字符）
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! FriendsContactCell
        let index = indexPath.item
        cell.nameLabel.text = data[index].name
        cell.titleLabel.text = data[index].title
        cell.avatarView.image = UIImage(named: data[index].avatar)
        if(index == data.count - 1) {
            cell.isLastCell = true
        } else {
            cell.isLastCell = false
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderIdentifier) as? FriendsContactHeader
        header?.label.text = "A"
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UX.HeightForHeader
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
