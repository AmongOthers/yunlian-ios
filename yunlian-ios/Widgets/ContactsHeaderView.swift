//
//  ContactsHeaderView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/16.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class ContactsHeaderView: UIView {
    private struct UX {
        static let TitleLabelLeftOffset = 8
        static let ArrowRightOffset = 8
        static let ArrowSize = 18
    }
    
    var titleLabel: UILabel!
    var arrowImageView: UIImageView!
    var isUpSideDown = false

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NotImplemented")
    }
    
    convenience init(title: String, isUpSideDown: Bool) {
        self.init(frame: CGRectZero)
        self.isUpSideDown = isUpSideDown
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.textColor = UIConstants.FontColorGray
        titleLabel.font = UIConstants.DefaultMediumFont
        arrowImageView = UIImageView()
        addSubview(arrowImageView)
        arrowImageView.userInteractionEnabled = true
        arrowImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "arrowTapped"))
        arrowImageView.image = UIImage(named: "up")
        if(isUpSideDown) {
            arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        setupConstraints()
    }
    
    func arrowTapped() {
        if(isUpSideDown) {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.arrowImageView.transform = CGAffineTransformIdentity
            })
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            })
        }
        isUpSideDown = !isUpSideDown
    }
    
    func setupConstraints() {
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(UX.TitleLabelLeftOffset)
            make.centerY.equalTo(self)
        }
        arrowImageView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-UX.ArrowRightOffset)
            make.centerY.equalTo(self)
            make.width.height.equalTo(UX.ArrowSize)
        }
    }
}
