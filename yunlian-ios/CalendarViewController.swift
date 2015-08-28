//
//  CalendarViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/26.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    struct UX {
        static let HeightForRow:CGFloat = 20
        static let CalendarOffset:CGFloat = 0
        static let MaxRow:CGFloat = 6
        static let RowHeight:CGFloat = 45
        static let HeaderHieght:CGFloat = 37
    }
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    
    var collectionView: UICollectionView!
    var buttonPre: UIButton!
    var buttonNext: UIButton!
    var calendarDate: CalendarDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            make.right.equalTo(self.view.snp_right).offset(-UX.CalendarOffset)
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.height.equalTo(UX.MaxRow * UX.RowHeight + UX.HeaderHieght)
        }
        calendarDate = CalendarDate()
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
