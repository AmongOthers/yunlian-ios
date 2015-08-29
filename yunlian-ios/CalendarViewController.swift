//
//  CalendarViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/26.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    struct UX {
        static let HeightForRow:CGFloat = 20
        static let CalendarOffset:CGFloat = 0
        static let MaxRow:CGFloat = 6
        static let RowHeight:CGFloat = 45
        static let HeaderHieght:CGFloat = 37
        static let TabelRowHeight:CGFloat = 80
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    let TableCellIdentifier = "TableCellIdentifier"
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var buttonPre: UIButton!
    var buttonNext: UIButton!
    var calendarDate: CalendarDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConstants.BackgroundGray
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - UX.CalendarOffset) / 7
        layout.itemSize = CGSizeMake(width, UX.RowHeight)
        layout.headerReferenceSize = CGSizeMake(view.frame.width - UX.CalendarOffset, UX.HeaderHieght)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CalendarCell.self, forCellWithReuseIdentifier: CellIdentifier)
        collectionView.registerClass(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.height.equalTo(UX.MaxRow * UX.RowHeight + UX.HeaderHieght)
        }
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        collectionView.addGestureRecognizer(swipeUp)
        collectionView.addGestureRecognizer(swipeDown)
        calendarDate = CalendarDate()
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CalendarTableViewCell.self, forCellReuseIdentifier: TableCellIdentifier)
        tableView.bounces = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        let rows = calendarDate.rows
        tableView.snp_remakeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.collectionView.snp_bottom).offset(-UX.RowHeight * CGFloat(6 - rows))
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
        }
    }
    
    func swiped(recognizer: UISwipeGestureRecognizer) {
        let originRows = calendarDate.rows
        if recognizer.direction == UISwipeGestureRecognizerDirection.Up {
            calendarDate.nextMonth()
        } else {
            calendarDate.previousMonth()
        }
        let rows = calendarDate.rows
        collectionView.reloadData()
        if originRows != rows {
            tableView.snp_remakeConstraints { (make) -> Void in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.collectionView.snp_bottom).offset(-UX.RowHeight * CGFloat(6 - rows))
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.TabelRowHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifier, forIndexPath: indexPath) as! CalendarTableViewCell
        cell.titleLabel.text = "日程标题"
        cell.locationLabel.text = "亚马孙会议室"
        cell.startTimeLabel.text = "10:00"
        cell.endTimeLabel.text = "12:00"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! CalendarCell
        if indexPath.row < calendarDate.startIndex {
            cell.numberLabel.text = ""
        } else if indexPath.row < calendarDate.startIndex + calendarDate.monthDays {
            cell.numberLabel.text = "\(indexPath.row - calendarDate.startIndex + 1)"
        } else {
            cell.numberLabel.text = ""
        }
        let today = calendarDate.today
        if calendarDate.currentDate.isSameMonthOf(today) {
            if indexPath.row - calendarDate.startIndex + 1 == today.day {
                cell.isToday = true
            }
        } else {
            cell.isToday = false
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier, forIndexPath: indexPath) as! CalendarHeaderView
        return view
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row < calendarDate.startIndex || indexPath.row >= calendarDate.startIndex + calendarDate.monthDays {
            return false
        }
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CalendarCell
        cell.isChoosed = true
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CalendarCell
        cell.isChoosed = false
    }
}
