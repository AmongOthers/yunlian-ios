//
//  LoadingAlertController.swift
//  yunlian-ios
//
//  Created by zikang zou on 25/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class LoadingAlertController: UIAlertController {
    
    struct UX {
    }
    
    var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
        indicator.startAnimating()
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        super.dismissViewControllerAnimated(flag, completion: completion)
        indicator.stopAnimating()
    }
    
    func setupViews() {
        view.subviews.forEach { (subview) -> () in
            subview.hidden = true
        }
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        view.addSubview(indicator)
        indicator.tintColor = UIConstants.TintColor
        indicator.color = UIConstants.TintColor
    }
    
    func setupConstraints() {
        indicator.snp_remakeConstraints { (make) -> Void in
            make.center.equalTo(view)
        }
    }
}
