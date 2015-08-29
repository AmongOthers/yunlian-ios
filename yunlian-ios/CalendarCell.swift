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
        static let TodayTextColor = UIColor(rgb: 0xd54a59)
        static let SelectionViewColor = UIConstants.BackgroundColor.colorWithAlphaComponent(0.5)
        static let BubbleCornerRadius:CGFloat = 10
        static let BubbleFont = UIFont.systemFontOfSize(13)
    }
    
    static var SelectionViewSize:CGFloat = 42
    
    var selectionView: UIView!
    var numberLabel: UILabel!
    var bubbleLabel: UILabel!
    var bubbleNumber: Int = 0 {
        didSet {
            if bubbleNumber > 0 {
                if bubbleLabel.hidden {
                    bubbleLabel.hidden = false
                    bubbleLabel.text = bubbleNumber > 99 ? "99+" : "\(bubbleNumber)"
                    bubbleLabel.snp_removeConstraints()
                    bubbleLabel.snp_remakeConstraints { (make) -> Void in
                        make.bottom.equalTo(contentView.snp_top).offset(UX.BubbleCornerRadius * 2)
                        make.left.equalTo(contentView.snp_right).offset(-UX.BubbleCornerRadius * 2)
                        make.width.greaterThanOrEqualTo(UX.BubbleCornerRadius * 2)
                        make.height.equalTo(UX.BubbleCornerRadius * 2)
                    }
                    UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                        self.layoutIfNeeded()
                        }, completion: { _ -> Void in
                            
                    })
                } else {
                    bubbleLabel.text = bubbleNumber > 99 ? "99+" : "\(bubbleNumber)"
                }
            } else {
                bubbleLabel.snp_remakeConstraints { (make) -> Void in
                    make.top.equalTo(contentView)
                    make.right.equalTo(contentView)
                    make.width.height.equalTo(2)
                }
                UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
                    self.bubbleLabel.layoutIfNeeded()
                    }, completion: { (finished) -> Void in
                        if finished {
                            self.bubbleLabel.hidden = true
                            self.bubbleLabel.text = ""
                        }
                })
            }
        }
    }
    
    var isChoosed = false {
        didSet {
            if isChoosed {
                selectionView.backgroundColor = UIConstants.TintColor
            } else {
                selectionView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    var isToday = false {
        didSet {
            if isToday {
                numberLabel.textColor = UX.TodayTextColor
            } else {
                numberLabel.textColor = UIConstants.FontColorGray
            }
        }
    }
    
    func clearState() {
        selectionView.backgroundColor = UIColor.clearColor()
        bubbleNumber = 0
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
        selectionView.layer.cornerRadius = CalendarCell.SelectionViewSize / 2
        numberLabel = UILabel()
        selectionView.addSubview(numberLabel)
        numberLabel.font = UIFont.systemFontOfSize(UX.NumberFontSize)
        numberLabel.textColor = UIConstants.FontColorGray
        bubbleLabel = UILabel()
        contentView.addSubview(bubbleLabel)
        bubbleLabel.backgroundColor = UIConstants.TintColorGreen
        bubbleLabel.textColor = UIColor.whiteColor()
        bubbleLabel.font = UX.BubbleFont
        bubbleLabel.layer.cornerRadius = UX.BubbleCornerRadius
        bubbleLabel.clipsToBounds = true
        bubbleLabel.hidden = true
        bubbleLabel.textAlignment = NSTextAlignment.Center
    }
    
    func setupConstraints() {
        selectionView.snp_remakeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.contentView)
            make.width.height.equalTo(CalendarCell.SelectionViewSize)
        }
        numberLabel.snp_remakeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.contentView)
        }
        bubbleLabel.snp_remakeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView.snp_top).offset(UX.BubbleCornerRadius * 2)
            make.left.equalTo(contentView.snp_right).offset(-UX.BubbleCornerRadius * 2)
            make.width.height.equalTo(20)
        }
    }
}
