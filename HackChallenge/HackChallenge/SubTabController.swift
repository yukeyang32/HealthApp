//
//  SubTabController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/11/20.
//

import UIKit

class SubTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityView = ActivityListController()
//         activityView.tabBarItem = UITabBarItem(title: "Activities", image: nil, tag: 1)
        let foodView = FoodViewController()
//         foodView.tabBarItem = UITabBarItem(title: "Food", image: nil, tag: 2)
        self.viewControllers = [activityView, foodView]
    }
}
