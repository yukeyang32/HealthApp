//
//  SubTabController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/11/20.
//

import UIKit

class SubTabController: UITabBarController, UITabBarControllerDelegate {
    var date: Date!
    init(date:Date){
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityView = ActivityListController(date: self.date)
        activityView.tabBarItem = UITabBarItem(title: "Activities", image: nil, tag: 1)
        let foodView = FoodViewController()
        foodView.tabBarItem = UITabBarItem(title: "Food", image: nil, tag: 2)
        self.viewControllers = [activityView, foodView]
//        self.delegate = self
    }
    
//    func tabBarController(_ tabBarController: UITabBarController,
//                                   didSelect viewController: UIViewController){
//        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Current Plan(\(3))", style: .plain, target: self, action: #selector(addPlanViewController))
//    }
}
