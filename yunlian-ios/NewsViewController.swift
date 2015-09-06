//
//  NewsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    struct UX {
        static let HeightForRow: CGFloat = 228
        static let HeightForHeader: CGFloat = 33
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    
    var tableView: UITableView!
    var data = [NSDate: [News]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        data[NSDate.date(fromString: "2015/09/05", format: .Custom("yyyy/MM/dd"))!]  = [News(person: Person(name: "郑文伟", title: "高级软件工程师", avatar: "2")), News(person: Person(name: "郑文伟", title: "高级软件工程师", avatar: "3"))]
        data[NSDate.date(fromString: "2015/09/04", format: .Custom("yyyy/MM/dd"))!]  = [News(person: Person(name: "郑文伟", title: "高级软件工程师", avatar: "3")), News(person: Person(name: "郑文伟", title: "高级软件工程师", avatar: "1"))]
        data[NSDate.date(fromString: "2015/09/03", format: .Custom("yyyy/MM/dd"))!]  = [News(person: Person(name: "郑文伟", title: "高级软件工程师", avatar: "3")), News(person: Person(name: "郑文伟", title: "高级软件工程师", avatar: "1"))]
        setupViews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = UIConstants.BackgroundGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(NewsHeader.self, forHeaderFooterViewReuseIdentifier: HeaderIdentifier)
        tableView.registerClass(NewsCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
    }
    
    func setupConstraints() {
        tableView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
            make.left.right.equalTo(self.view)
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! NewsCell
        let section = indexPath.section
        let index = indexPath.item
        var i = 0
        var newsArray: [News]!
        for (_, news) in data {
            if i == section {
                newsArray = news
                break
            }
            i++
        }
        let news = newsArray[index]
        cell.nameLabel.text = news.person.name
        cell.titleLabel.text = news.person.title
        cell.avatarView.image = UIImage(named: news.person.avatar)
        cell.dateDescriptionLabel.text = news.dateDescription
        cell.locationDescriptionLabel.text = news.locationDescription
        cell.notifyDescriptionLabel.text = news.notifyDescription
        cell.timeLabel.text = news.date.toString(format: .Custom("hh:mm"))
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderIdentifier) as! NewsHeader
        var i = 0
        var theKey:NSDate!
        for (key, _) in data {
            if i == section {
                theKey = key
                break
            }
            i++
        }
        header.label.setTitle(theKey.toString(format: DateFormat.Custom("yyyy/MM/dd")), forState: UIControlState.Normal)
        return header
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.HeightForRow
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UX.HeightForHeader
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var i = 0
        var newsArray: [News]!
        for (_, news) in data {
            if i == section {
                newsArray = news
                break
            }
            i++
        }
        return newsArray.count
    }
}
