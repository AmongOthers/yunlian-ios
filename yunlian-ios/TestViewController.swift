//
//  TestViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/22.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    var testView: UIView!
    var titleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleView = TitleSearchView()
        titleView.frame = CGRectMake(0, 0, view.frame.size.width, 36)
        self.navigationItem.titleView = titleView
//        titleView.snp_remakeConstraints { (make) -> Void in
//            make.width.equalTo(view)
//            make.height.equalTo(44)
//        }
//        testView = ContactsPanelView()
//        view.addSubview(testView)
//        testView.snp_remakeConstraints { (make) -> Void in
//            make.width.equalTo(105)
//            make.height.equalTo(60)
//            make.center.equalTo(view)
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
