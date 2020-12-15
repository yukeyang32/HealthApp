//
//  ViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate{
    var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        createFood(name: "Carrot", cal: 95, unit: "carrot")
        createFood(name: "Banana", cal: 105, unit: "banana")
        createFood(name: "Beef", cal: 250, unit: "100 grams")
        createFood(name: "Chocolate", cal: 546, unit: "100 grams")
        
        view.backgroundColor = .white
        title = "Select The Date"
        calendar = FSCalendar(frame: CGRect(x: 0.0, y:40.0, width:self.view.frame.size.width, height:600.0))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        self.view.addSubview(calendar)
        calendar.delegate = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let tabView = SubTabController(date: date)
        navigationController?.pushViewController(tabView, animated: true)
    }
}

extension ViewController {
    private func createFood(name: String, cal: Int, unit: String) {
        NetworkManager.createFood(name: name, cal: cal, unit: unit) { _ in
        }
    }
}
