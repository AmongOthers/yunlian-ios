//
//  SearchContactsViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/23.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit

class SearchContactsViewController: UIViewController, TitleSearchViewDelegate, UITextFieldDelegate {
    
    struct UX {
        static let TitleSearchViewHeight:CGFloat = 36
        static let ResultTopOffset:CGFloat = 8
    }
    
    var titleView: TitleSearchView!
    var backgroundImage: UIImage?
    var backgroundImageView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        if backgroundImage != nil {
            backgroundImageView = UIImageView(image: backgroundImage)
            view.addSubview(backgroundImageView!)
            backgroundImageView?.snp_remakeConstraints(closure: { (make) -> Void in
                make.edges.equalTo(self.view)
            })
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
            view.addSubview(blur)
            blur.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(view)
            }
        }
        navigationItem.hidesBackButton = true
        titleView = TitleSearchView()
        titleView.frame = CGRectMake(0, 0, view.frame.size.width, UX.TitleSearchViewHeight)
        titleView.delegate = self
        navigationItem.titleView = titleView
        titleView.textField.becomeFirstResponder()
        titleView.textField.delegate = self
        setupViews()
        setupConstraints()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleView.textField.resignFirstResponder()
        let resultController = SearchContactsResultController()
        addChildViewController(resultController)
        view.addSubview(resultController.view)
        resultController.view.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UX.ResultTopOffset)
            make.left.bottom.right.equalTo(view)
        }
        resultController.didMoveToParentViewController(self)
        return true
    }
    
    func cancelTapped() {
        navigationController?.popViewControllerAnimated(false)
//        navigationController?.dismissViewControllerAnimated(false, completion: { () -> Void in
//        })
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
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
