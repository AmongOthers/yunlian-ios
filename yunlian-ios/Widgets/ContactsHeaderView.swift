//
//  ContactsHeaderView.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/16.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

protocol ContactsHeaderViewDelegate {
    func headerTapped(header: ContactsHeaderView)
}

class ContactsHeaderView: UIView {
    private struct UX {
        static let TitleLabelLeftOffset = 8
        static let ArrowRightOffset = 8
        static let ArrowSize = 18
    }
    
    var titleLabel: UILabel!
    var state: ContactsViewControllerState!
    var arrowTouchView: UIView!
    var arrowImageView: UIImageView!
    var isOpen = false
    var delegate: ContactsHeaderViewDelegate?

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
    
    convenience init(title: String, isOpen: Bool, state: ContactsViewControllerState) {
        self.init(frame: CGRectZero)
        self.isOpen = isOpen
        self.state = state
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.textColor = UIConstants.FontColorGray
        titleLabel.font = UIConstants.DefaultMediumFont
        arrowTouchView = UIView()
        addSubview(arrowTouchView)
        arrowImageView = UIImageView()
        arrowTouchView.addSubview(arrowImageView)
        arrowTouchView.userInteractionEnabled = true
        arrowTouchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "arrowTapped"))
        arrowImageView.image = UIImage(named: "up")
        if(!isOpen) {
            arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        setupConstraints()
    }
    
    func arrowTapped() {
        delegate?.headerTapped(self)
//        if(!isOpen) {
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.arrowImageView.transform = CGAffineTransformIdentity
//            })
//        } else {
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
//            })
//        }
//        isOpen = !isOpen
    }
    
    func setupConstraints() {
        titleLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(UX.TitleLabelLeftOffset)
            make.centerY.equalTo(self)
        }
        arrowTouchView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(UIConstants.UserTouchAreaSize)
        }
        arrowImageView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self.arrowTouchView).offset(-UX.ArrowRightOffset)
            make.centerY.equalTo(self.arrowTouchView)
            make.width.height.equalTo(UX.ArrowSize)
        }
    }
    
    func open() {
        self.arrowImageView.transform = CGAffineTransformIdentity
    }
    
    func close() {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }
}
