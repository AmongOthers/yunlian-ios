//
//  NewFriendViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/9/6.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import UIKit

class NewFriendViewController: UIViewController {
    
    struct UX {
        static let LeftViewWidth:CGFloat = 40
        static let LeftViewHeight:CGFloat = 34
        static let CornerRadius:CGFloat = 3
        static let Offset = 16
        static let TitleSearchViewHeight:CGFloat = 36
        static let IdLabelLeftOffset: CGFloat = 32
        static let IdLabelTopOffset: CGFloat = 8
        static let QrCodeImageSize:CGFloat = 44
        static let ImageOffset = 32
        static let PanelSize:CGFloat = 200
        static let QrCodeSize:CGFloat = 140
        static let QrCodeMinSize:CGFloat = 10
        static let QrCodePanelRightOffset:CGFloat = 22
        static let QrCodePanelTopOffset:CGFloat = 10.5
        static let NewFriendLabelTopOffset: CGFloat = 8
        static let HeightForRow:CGFloat = 59
    }
    
    let CellIdentifier = "CellIdentifier"
    var data:[Person] = [Person]()
    
    var searchTextField: UITextField!
    var idLabel: UILabel!
    var qrCodeView: UIImageView!
    var newFriendLabel: UILabel!
    //二维码点击时的放大显示和遮罩
    var panelMask: UIView!
    var qrCodePanel: UIView!
    var qrCodeImageView: UIImageView!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加朋友"
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "1"))
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "2"))
        data.append(Person(name: "郑文伟", title: "高级软件工程师", avatar: "3"))
        setupViews()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        view.backgroundColor = UIConstants.BackgroundGray
        searchTextField = UITextField()
        view.addSubview(searchTextField)
        searchTextField.leftView = TextFieldLeftView(frame: CGRectMake(0, 0, UX.LeftViewWidth, UX.LeftViewHeight), image: UIImage(named: "searchItem")!)
        searchTextField.leftViewMode = UITextFieldViewMode.Always
        searchTextField.placeholder = "云联ID/手机号码"
        searchTextField.layer.cornerRadius = UX.CornerRadius
        searchTextField.backgroundColor = UIColor.whiteColor()
        searchTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        searchTextField.tintColor = UIConstants.TintColor
        searchTextField.returnKeyType = UIReturnKeyType.Search
        searchTextField.delegate = self
        
        idLabel = UILabel()
        view.addSubview(idLabel)
        idLabel.text = "我的云联ID: 145895"
        idLabel.font = UIConstants.DefaultMediumFont
        idLabel.textColor = UIConstants.FontColorSecondGray
        qrCodeView = UIImageView()
        view.addSubview(qrCodeView)
        let qrCodeImage = UIImage(named: "qrCode")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        qrCodeView.tintColor = UIConstants.TintColor
        qrCodeView.image = qrCodeImage
        qrCodeView.userInteractionEnabled = true
        qrCodeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "qrCodeTapped"))
        
        newFriendLabel = UILabel()
        view.addSubview(newFriendLabel)
        newFriendLabel.text = "新的朋友"
        newFriendLabel.font = UIConstants.DefaultMediumFont
        newFriendLabel.textColor = UIConstants.FontColorSecondGray
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = UIConstants.BackgroundGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(NewFriendCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableFooterView = UIView()
        tableView.bounces = false
        
        let tuple = Helper.panelView(view, target: self, action: "maskTapped")
        panelMask = tuple.mask
        qrCodePanel = tuple.panel
        qrCodePanel.backgroundColor = UIColor.whiteColor()
        qrCodePanel.layer.cornerRadius = UIConstants.DefaultButtonCornerRadius
        qrCodePanel.layer.shadowColor = UIConstants.FirstGray.CGColor
        qrCodePanel.layer.shadowOpacity = 1
        qrCodeImageView = UIImageView()
        qrCodePanel.addSubview(qrCodeImageView)
        qrCodeImageView.image = UIImage(named: "qrdemo")
        qrCodeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        panelMask.hidden = true
        qrCodePanel.hidden = true
    }

    func setupConstraints() {
        searchTextField.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(UX.Offset)
            make.left.equalTo(view).offset(UX.Offset)
            make.right.equalTo(view).offset(-UX.Offset)
            make.height.equalTo(UX.TitleSearchViewHeight)
        }
        qrCodeView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(searchTextField.snp_bottom).offset(UX.IdLabelTopOffset)
            make.width.height.equalTo(UX.QrCodeImageSize)
            make.right.equalTo(view).offset(-UX.ImageOffset)
        }
        idLabel.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(searchTextField.snp_bottom).offset(UX.IdLabelTopOffset)
            make.left.equalTo(view).offset(UX.IdLabelLeftOffset)
            make.centerY.equalTo(qrCodeView)
        }
        newFriendLabel.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(idLabel)
            make.top.equalTo(qrCodeView.snp_bottom).offset(UX.NewFriendLabelTopOffset)
        }
        qrCodePanel.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.QrCodeMinSize)
            make.right.equalTo(self.qrCodeView).offset(-UX.QrCodePanelRightOffset)
            make.top.equalTo(self.qrCodeView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
        }
        qrCodeImageView.snp_remakeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.qrCodePanel)
            make.width.height.equalTo(self.qrCodePanel).multipliedBy(0.7)
        }
        tableView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo(newFriendLabel.snp_bottom).offset(UX.NewFriendLabelTopOffset)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func qrCodeTapped() {
        if qrCodePanel.hidden {
            view.bringSubviewToFront(panelMask)
            panelMask.hidden = false
            qrCodePanel.hidden = false
            qrCodePanel.snp_remakeConstraints { (make) -> Void in
                make.width.height.equalTo(UX.PanelSize)
                make.right.equalTo(self.qrCodeView).offset(-UX.QrCodePanelRightOffset)
                make.top.equalTo(self.qrCodeView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
            }
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.qrCodePanel.layoutIfNeeded()
                }, completion: { _ -> Void in
                    
            })
        } else {
            qrCodePanel.snp_remakeConstraints { (make) -> Void in
                make.width.height.equalTo(UX.QrCodeMinSize)
                make.right.equalTo(self.qrCodeView).offset(-UX.QrCodePanelRightOffset)
                make.top.equalTo(self.qrCodeView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
            }
            UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
                self.qrCodePanel.layoutIfNeeded()
                }, completion: { (finished) -> Void in
                    if finished {
                        self.qrCodePanel.hidden = true
                    }
            })
        }
    }
    
    func maskTapped() {
        qrCodePanel.snp_remakeConstraints { (make) -> Void in
            make.width.height.equalTo(UX.QrCodeMinSize)
            make.right.equalTo(self.qrCodeView).offset(-UX.QrCodePanelRightOffset)
            make.top.equalTo(self.qrCodeView.snp_bottom).offset(-UX.QrCodePanelTopOffset)
        }
        UIView.animateWithDuration(UIConstants.DefaultAnimationDuration, animations: { () -> Void in
            self.qrCodePanel.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                if finished {
                    self.qrCodePanel.hidden = true
                    self.panelMask.hidden = true
                }
        })
    }
}

extension NewFriendViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        let image = UIImage(UIView: UIApplication.sharedApplication().keyWindow?.rootViewController?.view, andRect: CGRectMake(0, 64, view.frame.width, view.frame.height))
        let image = UIImage(UIView: UIApplication.sharedApplication().keyWindow?.rootViewController?.view)
        let searchController = SearchContactsViewController()
        searchController.backgroundImage = image
        searchController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchController, animated: false)
        return false
    }
}

extension NewFriendViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! FriendsContactCell
        let index = indexPath.item
        cell.nameLabel.text = data[index].name
        cell.titleLabel.text = data[index].title
        cell.avatarView.image = UIImage(named: data[index].avatar)
        if(index == data.count - 1) {
            cell.isLastCell = true
        }
        return cell
    }
}

extension NewFriendViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UX.HeightForRow
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "删除", handler: {(_, indexPath) in })
        let blackAction = UITableViewRowAction(style: .Normal, title: "拉黑", handler: {(_, indexPath) in })
        return [blackAction, deleteAction]
    }
    
    //在iOS8上是必要的设置，否则rowActions无效
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
}