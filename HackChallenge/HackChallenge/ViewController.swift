//
//  ViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//

import UIKit

class ViewController: UIViewController {
//    private let foodButton = UIButton()
    private let weekdayTableView = UITableView()
    private let weekReuseIdentifier = "WeekReuseIdentifier"
    private var weekdays:[Day] = []
    let monday = Day(day: "Monday")
    let tuesday = Day(day: "Tuesday")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekdays = [monday, tuesday]
        title = "Healthy Eating"
        view.backgroundColor = .white
        weekdayTableView.delegate = self
        weekdayTableView.dataSource = self
        weekdayTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weekdayTableView)
//        foodButton.setTitle("User Food", for: .normal)
//        foodButton.titleLabel?.font = .systemFont(ofSize: 40)
//        foodButton.setTitleColor(.black, for: .normal)
//        foodButton.translatesAutoresizingMaskIntoConstraints = false
//        foodButton.addTarget(self, action: #selector(presentFoodView), for: .touchUpInside)
//        view.addSubview(foodButton)
        setUpConstraints()
        
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            weekdayTableView.topAnchor.constraint(equalTo: view.topAnchor, constant:5),
            weekdayTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            weekdayTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
//        NSLayoutConstraint.activate([
//            foodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            foodButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            foodButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
    }
    
//    @objc func presentFoodView() {
//        let foodView = FoodViewController()
//        present(foodView, animated: true, completion: nil)
//    }
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabView = SubTabController()
        navigationController?.pushViewController(tabView, animated: true)
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: weekReuseIdentifier) as? WeekdayTableViewCell
        else {return UITableViewCell()}
        let weekday = weekdays[indexPath.row]
        cell.configure(for: weekday)
        return cell
    }
    
}
