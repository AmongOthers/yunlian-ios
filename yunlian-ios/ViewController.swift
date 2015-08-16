//
//  ViewController.swift
//  yunlian-ios
//
//  Created by AmongOthers on 15/8/15.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UITabBarController {
    var contactsController: ContactsViewController!
    var calendarController: CalendarViewController!
    var newsController: NewsViewController!
    var settingsController: SettingsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBar.tintColor = UIConstants.TintColor
        contactsController = ContactsViewController()
        contactsController.title = "名片夹"
        contactsController.tabBarItem = UITabBarItem(title: "名片夹", image: UIImage(named: "contacts"), selectedImage: UIImage(named: "contactsSelected"))
        calendarController = CalendarViewController()
        calendarController.title = "日程"
        calendarController.tabBarItem = UITabBarItem(title: "日程", image: UIImage(named: "calendar"), selectedImage: UIImage(named: "calendarSelected"))
        newsController = NewsViewController()
        newsController.title = "动态"
        newsController.tabBarItem = UITabBarItem(title: "动态", image: UIImage(named: "news"), selectedImage: UIImage(named: "newsSelected"))
        settingsController = SettingsViewController()
        settingsController.title = "我的"
        settingsController.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settingsSelected"))
        viewControllers = [UINavigationController(rootViewController: contactsController), UINavigationController(rootViewController: calendarController), UINavigationController(rootViewController: newsController), UINavigationController(rootViewController: settingsController)]
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupConstraints() {
    }

}

