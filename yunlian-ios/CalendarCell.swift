//
//  TableViewCell.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/26.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class CalendarCell: UICollectionViewCell {
    struct UX {
        static let NumberFontSize:CGFloat = 13
        static let SelectionViewColor = UIConstants.BackgroundColor.colorWithAlphaComponent(0.5)
        static let SelectionViewSize:CGFloat = 39
    }
    
    var selectionView: UIView!
    var numberLabel: UILabel!
    var isChoosed = false {
        didSet {
            if !isToday {
                if isChoosed {
                    selectionView.backgroundColor = UX.SelectionViewColor
                } else {
                    selectionView.backgroundColor = UIColor.clearColor()
                }
            }
            
        }
    }
    var isToday = false {
        didSet {
            if isToday {
                selectionView.backgroundColor = UIConstants.TintColor
            } else {
                selectionView.backgroundColor = UIColor.clearColor()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    func setupViews() {
        selectionView = UIView()
        contentView.addSubview(selectionView)
        selectionView.layer.cornerRadius = UX.SelectionViewSize / 2
        numberLabel = UILabel()
        selectionView.addSubview(numberLabel)
        numberLabel.font = UIFont.systemFontOfSize(UX.NumberFontSize)
        numberLabel.textColor = UIConstants.FontColorGray
    }
    
    func setupConstraints() {
        selectionView.snp_remakeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.contentView)
            make.width.height.equalTo(UX.SelectionViewSize)
        }
        numberLabel.snp_remakeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.contentView)
        }
    }
}
