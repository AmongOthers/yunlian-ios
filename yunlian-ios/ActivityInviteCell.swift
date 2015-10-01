//
//  ActivityInviteCell.swift
//  yunlian-ios
//
//  Created by zikang zou on 1/10/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ActivityInviteCell: ActivityBaseCell {
    
    var personCollectionView: UICollectionView!
    var inviteView: UIImageView!
    
    let PersonCellIdentifier = "PersonCellIdentifier"
    
    lazy var persons = {
        return Database.sharedInstance.fetchPersons()
    }()
    
    override func setupViews() {
        super.setupViews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(UX.PersonCellWidth, UX.PersonCellHeight)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.sectionInset = UIEdgeInsetsMake(UX.CollectionViewHorizontalInsets, UX.CollectionViewVerticalInsets, UX.CollectionViewHorizontalInsets, UX.CollectionViewVerticalInsets)
        personCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        contentView.addSubview(personCollectionView)
        personCollectionView.showsHorizontalScrollIndicator = false
        personCollectionView.backgroundColor = UIColor.whiteColor()
        personCollectionView.delegate = self
        personCollectionView.dataSource = self
        personCollectionView.bounces = false
        personCollectionView.registerClass(InvitePersonCell.self, forCellWithReuseIdentifier: PersonCellIdentifier)
        inviteView = UIImageView()
        contentView.addSubview(inviteView)
        inviteView.contentMode = UIViewContentMode.ScaleAspectFit
        inviteView.image = UIImage(named: "invite")
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        inviteView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-UX.RightOffset / 2)
            make.center.equalTo(contentView)
            make.width.right.equalTo(UX.ImageSize)
        }
        personCollectionView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(inviteView.snp_left)
            make.left.equalTo(label.snp_right).offset(UX.TextOffset)
            make.top.bottom.equalTo(contentView)
        }
    }
}

extension ActivityInviteCell: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PersonCellIdentifier, forIndexPath: indexPath) as! InvitePersonCell
        let person = persons![indexPath.row]
        cell.avatarView.image = UIImage(named: person.avatar)
        return cell
    }
}

extension ActivityInviteCell: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons?.count ?? 0
    }
}