//
//  PlanViewController.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/7/20.
//
import UIKit

class PlanViewController: UIViewController {
    
    var activities_pick: [(Activity,Int)]!
    var tableView: UITableView!
    var total_Cal_Field: UITextField!
    let reuseIdentifier = "Plan List"
    var total_cal:Int = 0 {
        didSet{
            total_Cal_Field.text = "Total Cal is \(total_cal)"
        }
    }
    init(for activities_pick: [(Activity,Int)]){
        super.init(nibName: nil, bundle: nil)
        total_Cal_Field = UITextField()
        self.activities_pick = activities_pick
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.'
        title = "Current Plan"
        view.backgroundColor = .white
//        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Current Plan(\(activities_pick.count))", style: .plain, target: self, action: #selector(addPlanViewController))
        for (act, amount) in activities_pick{
            total_cal += act.cal * amount
        }
        total_Cal_Field.translatesAutoresizingMaskIntoConstraints = false
        total_Cal_Field.text = "Total Cal is \(total_cal)"
        total_Cal_Field.borderStyle = .roundedRect
        total_Cal_Field.backgroundColor = .white
        total_Cal_Field.textAlignment = .center
        total_Cal_Field.clearsOnBeginEditing = true
        total_Cal_Field.isUserInteractionEnabled = false
        view.addSubview(total_Cal_Field)
        
        
        // Initialize tableView!
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: reuseIdentifier )
        view.addSubview(tableView)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
//        Setup the constraints for our views
        NSLayoutConstraint.activate([
            total_Cal_Field.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            total_Cal_Field.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            total_Cal_Field.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            total_Cal_Field.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: total_Cal_Field.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

extension PlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activities_pick.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlanTableViewCell
        let act = activities_pick[indexPath.row]
        cell.configure(for: act)
        return cell
    }
}

extension PlanViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let activity = activities[indexPath.row]
//        let vc =  ActivityDetailViewController(delegate: self, activity: activity, index:indexPath.row)
//        navigationController?.pushViewController(vc, animated: true)
////        let cafeteria = cafeterias[indexPath.row]
////        let cell = tableView.cellForRow(at: indexPath) as! CafeteriaTableViewCell
////        cafeteria.isFavorite.toggle()
////        cell.toggleHeart(for: cafeteria.isFavorite)
//    }
}
