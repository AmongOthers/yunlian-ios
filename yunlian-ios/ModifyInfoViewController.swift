//
//  ModifyInfoViewController.swift
//  yunlian-ios
//
//  Created by zikang zou on 28/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class ModifyInfoViewController: UIViewController {
    
    struct UX {
        static let RowHeight: CGFloat = 51.5
        static let TopOffset: CGFloat = 8
    }
    
    var tableView: UITableView!
    var button: UIButton!
    static let AvatarCellIdentifier = "Avatar"
    static let GenderCellIdentifier = "Gender"
    static let TextCellIdentifier = "Text"
    var textFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改个人资料"
        automaticallyAdjustsScrollViewInsets = false
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = UIConstants.BackgroundGray
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        tableView.registerClass(ModifyAvatarCell.self, forCellReuseIdentifier: ModifyInfoViewController.AvatarCellIdentifier)
        tableView.registerClass(ModifyGenderCell.self, forCellReuseIdentifier: ModifyInfoViewController.GenderCellIdentifier)
        tableView.registerClass(ModifyTextCell.self, forCellReuseIdentifier: ModifyInfoViewController.TextCellIdentifier)
    }
    
    func setupConstraints() {
        tableView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom).offset(UX.TopOffset)
            make.left.right.equalTo(view)
            make.height.equalTo(UX.RowHeight * 5)
        }
    }
    
}

extension ModifyInfoViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.RowHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if let textCell = cell as? ModifyTextCell {
            let textField = textCell.textField
            textFields.forEach({ (t) -> () in
                if t != textField {
                    if t.editing {
                        t.resignFirstResponder()
                    }
                    textField.becomeFirstResponder()
                }
            })
        } else if let genderCell = cell as? ModifyGenderCell {
            genderCell.toggle()
            view.endEditing(true)
        } else {
            view.endEditing(true)
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

extension ModifyInfoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0)) as! ModifyAvatarCell
        cell.avatar.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ModifyInfoViewController: UINavigationControllerDelegate {
}

extension ModifyInfoViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(ModifyInfoViewController.AvatarCellIdentifier)
            break
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(ModifyInfoViewController.GenderCellIdentifier)
            break
        default:
            let textCell = tableView.dequeueReusableCellWithIdentifier(ModifyInfoViewController.TextCellIdentifier) as! ModifyTextCell
            if indexPath.row == 2 {
                textCell.label.text = "公司"
            } else if indexPath.row == 3 {
                textCell.label.text = "头衔"
            } else {
                textCell.label.text = "个性签名"
                textCell.seperatorView.hidden = true
            }
            textFields.append(textCell.textField)
            cell = textCell
        }
        return cell
    }
}
