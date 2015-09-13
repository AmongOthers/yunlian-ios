//
//  ImageRemarkCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/12.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

@objc protocol ImageRemarkCellDelegate {
    func numberOfCells() -> Int
    func images() -> [UIImage]
    func addImageTapped(sender: ImageRemarkCell)
    func imageTapped(sender: ImageRemarkCell, index: Int)
}

class ImageRemarkCell: ProfileCell {
    
    struct UX {
        static let HInset: CGFloat = 13
        static let VInset: CGFloat = 14.5
    }
    
    var imageCollectionView: UICollectionView!
    let CellIdentifier = "CellIdentifier"
    let StubCellIdentifier = "StubCellIdentifier"
    weak var delegate: ImageRemarkCellDelegate?
    
    override func setupViews() {
        super.setupViews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (ProfileViewController.UX.ImageCellSize)!
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.sectionInset = UIEdgeInsetsMake(UX.VInset, UX.HInset, UX.VInset, UX.HInset)
        layout.minimumLineSpacing = UX.VInset
        
        imageCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        contentView.addSubview(imageCollectionView)
        imageCollectionView.backgroundColor = UIColor.whiteColor()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.bounces = false
        imageCollectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: CellIdentifier)
        imageCollectionView.registerClass(ImageStubCell.self, forCellWithReuseIdentifier: StubCellIdentifier)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        imageCollectionView.snp_remakeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
    }
}

extension ImageRemarkCell: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let imageCount = delegate?.numberOfCells() {
            return imageCount > 7 ? 8 : imageCount + 1
        } else {
            return 0
        }
    }
}

extension ImageRemarkCell: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let images = delegate?.images()
        if images != nil && images?.count >= indexPath.row + 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! ImageCell
            cell.imageView.image = images?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StubCellIdentifier, forIndexPath: indexPath) as! ImageStubCell
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = imageCollectionView.cellForItemAtIndexPath(indexPath)
        if cell is ImageStubCell {
            delegate?.addImageTapped(self)
        } else {
            delegate?.imageTapped(self, index: indexPath.row)
        }
    }
    
}
