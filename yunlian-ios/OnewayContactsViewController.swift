//
//  OnewayContactsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/20.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class OnewayContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    struct UX {
        static let HeightForRow:CGFloat = 59
    }
    
    let CellIdentifier = "CellIdentifier"
    
    var tableView: UITableView!
    var data:[Person]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = [Person]()
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "1"))
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "2"))
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "3"))
        
        // Do any additional setup after loading the view.
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        tableView.backgroundColor = UIConstants.BackgroundGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(OnewayContactCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
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
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.HeightForRow
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() {
        
    }
}
