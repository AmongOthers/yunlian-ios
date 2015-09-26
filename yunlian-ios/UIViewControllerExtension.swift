//
//  UIViewControllerExtension.swift
//  yunlian-ios
//
//  Created by zikang zou on 25/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit
import SwiftyJSON

extension UIViewController {
    
    func showSimpleMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "好", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showLoading() -> LoadingAlertController {
        let loading = LoadingAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        presentViewController(loading, animated: false, completion: nil)
        return loading
    }
    
    func yunlianRequest(api: Api, parameters: [String: AnyObject]?, whenSuccessful: JSON -> Void) {
        var afterLoading: (() -> Void)? = nil
        let loading = showLoading()
        YunlianNetwork.yunlianRequest(api, parameters: parameters) { result -> Void in
            defer {
                self.dismissViewControllerAnimated(false, completion: afterLoading)
            }
            switch result {
            case .Success(let json):
                let isSuccessful = json["isSucessed"].boolValue
                if isSuccessful {
                    afterLoading = { whenSuccessful(json) }
                } else {
                    let info = json["info"].stringValue
                    afterLoading = { self.showSimpleMessage("遇到问题", message: info) }
                }
                break
            case .NetworkNotConnected:
                afterLoading = { self.showSimpleMessage("未连接到互联网", message: "请检查网络配置") }
                break
            default:
                afterLoading = { self.showSimpleMessage("发生错误", message: "请重试") }
                break
            }
        }
    }
}
