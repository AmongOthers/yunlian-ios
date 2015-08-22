//
//  TestViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/21.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    var testView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.redColor()
        testView = UIView()
        view.addSubview(testView)
        testView.backgroundColor = UIColor.blueColor()
        testView.frame = CGRectMake(0, 0, 320, 10)
        
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
