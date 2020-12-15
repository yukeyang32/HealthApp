//
//  CalendarViewController.swift
//  HackChallenge
//
//  Created by YEXIN WU on 12/11/20.
//

import UIKit
import FSCalendar



class CalendarViewController: UIViewController, FSCalendarDelegate{
    var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Select The Date"
        // Do any additional setup after loading the view.
        calendar = FSCalendar(frame: CGRect(x: 0.0, y:40.0, width:self.view.frame.size.width, height:600.0))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        self.view.addSubview(calendar)
        calendar.delegate = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "M"
        let month = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "d"
        let day = Int(dateFormatter.string(from: date))
        print("\(year!) \(month!) \(day!)")
        let tabView = SubTabController(date: date)
        
        navigationController?.pushViewController(tabView, animated: true)
    }


}
