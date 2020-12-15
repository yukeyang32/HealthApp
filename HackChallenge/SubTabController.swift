//
//  SubTabController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/11/20.
//

import UIKit

class SubTabController: UITabBarController {
    var date : Date
    
    init(date:Date) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityView = ActivityListController()
        activityView.tabBarItem = UITabBarItem(title: "Activities", image: nil, tag: 1)
        let foodView = FoodViewController(date: date)
        foodView.tabBarItem = UITabBarItem(title: "Food", image: nil, tag: 2)
        self.viewControllers = [activityView, foodView]
        self.selectedViewController = activityView
    }
}


