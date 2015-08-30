//
//  CalendarViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/26.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, CalendarTableViewCellDelegate {
    
    struct UX {
        static let HeightForRow:CGFloat = 20
        static let CalendarOffset:CGFloat = 0
        static let MaxRow:CGFloat = 6
        static let RowHeight:CGFloat = 45
        static let HeaderHieght:CGFloat = 37
        static let TabelRowHeight:CGFloat = 80
        static let TodayButtonWidth:CGFloat = 72
        static let TodayButtonHeight:CGFloat = 25
        static let DatePickerButtonBarHeight:CGFloat = 40
        static let DatePickerButtonSize:CGFloat = 40
        static let DatePickerButtonBottomOffset:CGFloat = 64
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    let TableCellIdentifier = "TableCellIdentifier"
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var buttonPre: UIButton!
    var buttonNext: UIButton!
    var calendarDate: CalendarDate!
    var todayButton: UIButton!
    var choosedIndexPath: NSIndexPath?
    var choosedDate: NSDate {
        get {
            return calendarDate.currentDate.beginningOfMonth + (choosedIndexPath!.row - calendarDate.startIndex).days
        }
    }
    var datePicker: UIDatePicker!
    var datePickerMask: UIView!
    var datePickerOKButton: UIButton!
    
    var activities = [CalendarActivity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConstants.BackgroundGray
        automaticallyAdjustsScrollViewInsets = false
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - UX.CalendarOffset) / 7
        layout.itemSize = CGSizeMake(width, UX.RowHeight)
        layout.headerReferenceSize = CGSizeMake(view.frame.width - UX.CalendarOffset, UX.HeaderHieght)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.bounces = false
        CalendarCell.SelectionViewSize = UX.RowHeight
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
        
        reloadActivities()
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
        
        let item = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "monthLabelTapped")
        item.title = calendarDate.dateText
        item.tintColor = UIConstants.TintColor
        navigationItem.leftBarButtonItem = item
        
        let searchItem = UIBarButtonItem(image: UIImage(named: "searchItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "searchTapped")
        let addItem = UIBarButtonItem(image: UIImage(named: "addItem"), style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped")
        navigationItem.rightBarButtonItems = [addItem, searchItem]
        
        todayButton = UIButton()
        todayButton.frame = CGRectMake((view.frame.width - UX.TodayButtonWidth) / 2, (44 - UX.TodayButtonHeight) / 2, UX.TodayButtonWidth, UX.TodayButtonHeight)
        todayButton.setTitle("今天", forState: UIControlState.Normal)
        todayButton.addTarget(self, action: "todayTapped", forControlEvents: UIControlEvents.TouchUpInside)
        todayButton.setTitleColor(UIConstants.FontColorGray , forState: UIControlState.Normal)
        todayButton.backgroundColor = UIColor.whiteColor()
        todayButton.titleLabel?.font = UIConstants.DefaultMediumFont
        todayButton.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        navigationItem.titleView = todayButton
        
        datePickerMask = UIView()
        view.addSubview(datePickerMask)
        datePickerMask.backgroundColor = UIConstants.MaskColor
        datePickerMask.userInteractionEnabled = true
        datePickerMask.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "maskTapped:"))
        datePickerMask.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePickerMask.addSubview(datePicker)
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.snp_remakeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.datePickerMask)
            make.centerY.equalTo(self.datePickerMask)
        })
        datePickerOKButton = UIButton()
        datePickerMask.addSubview(datePickerOKButton)
        datePickerOKButton.setBackgroundImage(UIImage(named: "okmark"), forState: UIControlState.Normal)
        datePickerOKButton.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(2)
            make.centerX.equalTo(datePickerMask)
            make.centerY.equalTo(datePickerMask.snp_bottom).offset(-UX.DatePickerButtonBottomOffset - UX.DatePickerButtonSize / 2)
        }
        datePickerOKButton.addTarget(self, action: "okTapped", forControlEvents: UIControlEvents.TouchUpInside)
        datePickerMask.hidden = true
    }
    
    func searchTapped() {
        let cell = collectionView.cellForItemAtIndexPath(choosedIndexPath!) as! CalendarCell
        cell.bubbleNumber = 0
    }
    
    func addTapped() {
        let cell = collectionView.cellForItemAtIndexPath(choosedIndexPath!) as! CalendarCell
        cell.bubbleNumber = cell.bubbleNumber + 1
    }
    
    func monthLabelTapped() {
        toggleMask()
    }
    
    func maskTapped(recognizer: UITapGestureRecognizer) {
        let point = recognizer.locationInView(datePickerOKButton)
        if abs(point.x - UX.DatePickerButtonSize) <= 80 && abs(point.y - UX.DatePickerButtonSize) <= 40 {
            okTapped()
        }
        toggleMask()
    }
    
    func toggleMask() {
        if datePickerMask.hidden {
            datePickerMask.hidden = false
            datePickerOKButton.snp_remakeConstraints { (make) -> Void in
                make.width.height.equalTo(UX.DatePickerButtonSize)
                make.centerX.equalTo(datePickerMask)
                make.centerY.equalTo(datePickerMask.snp_bottom).offset(-UX.DatePickerButtonBottomOffset - UX.DatePickerButtonSize / 2)
            }
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.datePickerOKButton.layoutIfNeeded()
                }, completion: { _ -> Void in
                    
            })
        } else {
            datePickerOKButton.snp_remakeConstraints { (make) -> Void in
                make.width.height.equalTo(2)
                make.centerX.equalTo(datePickerMask)
                make.centerY.equalTo(datePickerMask.snp_bottom).offset(-UX.DatePickerButtonBottomOffset - UX.DatePickerButtonSize / 2)
            }
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
                self.datePickerOKButton.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    if finished {
                        self.datePickerMask.hidden = true
                    }
            })
        }
    }
    
    func okTapped() {
        toggleMask()
        let date = datePicker.date
        if date.isSameMonthOf(choosedDate) {
            if !date.isEqualToDate(choosedDate, ignoreTime: true) {
                changeDayInCurrentMonth(date)
            }
        } else {
            calendarDate.setDate(date)
            updateCalendarState()
        }
    }
    
    func swiped(recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == UISwipeGestureRecognizerDirection.Up {
            calendarDate.nextMonth()
        } else {
            calendarDate.previousMonth()
        }
        updateCalendarState()
    }
    
    func changeDayInCurrentMonth(date: NSDate) {
        let originChoosedCell = collectionView.cellForItemAtIndexPath(choosedIndexPath!) as! CalendarCell
        originChoosedCell.isChoosed = false
        let indexPath = NSIndexPath(forRow: date.day - 1 + calendarDate.startIndex, inSection: 0)
        choosedIndexPath = indexPath
        let choosedCell = collectionView.cellForItemAtIndexPath(choosedIndexPath!) as! CalendarCell
        choosedCell.isChoosed = true
        reloadActivities()
        tableView.reloadData()
    }
    
    func todayTapped() {
        let today = calendarDate.today
        if !choosedDate.isEqualToDate(today, ignoreTime: true) {
            if !choosedDate.isSameMonthOf(today) {
                calendarDate.setDate(today)
                updateCalendarState()
            } else {
                changeDayInCurrentMonth(today)
            }
        }
    }
    
    func updateCalendarState() {
        let indexPath = NSIndexPath(forRow: calendarDate.currentDate.day - 1 + calendarDate.startIndex, inSection: 0)
        let originChoosedCell = collectionView.cellForItemAtIndexPath(choosedIndexPath!) as! CalendarCell
        originChoosedCell.isChoosed = false
        choosedIndexPath = indexPath
        collectionView.reloadData()
        reloadActivities()
        tableView.reloadData()
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        tableView.snp_remakeConstraints { (make) -> Void in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.collectionView.snp_bottom).offset(-UX.RowHeight * CGFloat(6 - calendarDate.rows))
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
            }
        navigationItem.leftBarButtonItem?.title = calendarDate.dateText
    }
    
    func reloadActivities() {
        activities.removeAll()
        for i in 0...5 {
            let activity = CalendarActivity(title: "日程标题", location: "亚马逊会议室", startTime: NSDate(), endTime: NSDate())
            activities.append(activity)
        }
    }
    
    // MARK:- tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let activity = activities[indexPath.row]
        if activity.isPeopleShowed {
            return UX.TabelRowHeight + CalendarTableViewCell.UX.PeopleBarHeight
        } else {
            return UX.TabelRowHeight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableCellIdentifier, forIndexPath: indexPath) as! CalendarTableViewCell
        let activity = activities[indexPath.row]
        cell.activity = activity
        cell.delegate = self
        return cell
    }
    
    // MARK:- CalendarTableViewCellDelegate
    func toggleTapped(activity: CalendarActivity) {
        activity.isPeopleShowed = !activity.isPeopleShowed
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CalendarTableViewCell
//        cell.isPeopleShowed = true
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CalendarTableViewCell
//        cell.isPeopleShowed = false
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
    
    // MARK:- collectionView
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! CalendarCell
        cell.clearState()
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
        if let i = choosedIndexPath {
            if i == indexPath {
                cell.isChoosed = true
            }
        } else {
            if cell.isToday {
                cell.isChoosed = true
                choosedIndexPath = indexPath
            }
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
        let originChoosedCell = collectionView.cellForItemAtIndexPath(choosedIndexPath!) as! CalendarCell
        originChoosedCell.isChoosed = false
        choosedIndexPath = indexPath
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CalendarCell
        cell.isChoosed = true
    }
}
