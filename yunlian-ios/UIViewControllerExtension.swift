//
//  UIViewControllerExtension.swift
//  yunlian-ios
//
//  Created by zikang zou on 25/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSimpleMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "好", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showLoading() -> LoadingAlertController {
        let loading = LoadingAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        presentViewController(loading, animated: true, completion: nil)
        return loading
    }
}
