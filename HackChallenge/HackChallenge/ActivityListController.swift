//
//  ActivityListController.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/6/20.
//
import  UIKit

protocol AddRemoveDelegte: class {
    
    func addToPlan(index:Int,hours:Int)
    func addSongName(song_name:String, artists_name: String, album_name: String)
}


class ActivityListController: UIViewController {
    
    var tableView: UITableView!
    
    var current_plan: UIButton!
    
    var activities: [Activity]!
    let reuseIdentifier = "Activity List"
    let ac1 = Activity(activity_name: "Swimming", cal: 100, unit: (100,"100m"), picture: "Swimming")
    
    let ac2 = Activity(activity_name: "Jogging", cal: 100, unit: (100,"100m"), picture: "Jogging")
    
    var activities_pick: [(Activity,Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.'
        activities = [ac1,ac2]
//        title = "ActivityList"
        view.backgroundColor = .white
//        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Current Plan(\(activities_pick.count))", style: .plain, target: self, action: #selector(addPlanViewController))
        
        current_plan = UIButton()
        current_plan.backgroundColor = .black
        current_plan.setTitle("Current Plan(\(activities_pick.count))", for:  UIControl.State.normal)
        current_plan.addTarget(self, action:#selector(addPlanViewController), for: .touchUpInside)
        current_plan.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(current_plan)
        
        // Initialize tableView!
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: reuseIdentifier )
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
//        Setup the constraints for our views
        NSLayoutConstraint.activate([
            current_plan.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            current_plan.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            current_plan.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            current_plan.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: current_plan.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func addPlanViewController() {
        // If let statements can also chain boolean checks after them, like a normal if statement.
        // To dismiss something modally, we use the dismiss(animated:completion) command.
        let vc = PlanViewController(for:activities_pick)
        navigationController?.pushViewController(vc, animated: false)
            
    }
}

extension ActivityListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ActivityTableViewCell
        let song = activities[indexPath.row]
        cell.configure(for: song)
        return cell
    }
}

extension ActivityListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = activities[indexPath.row]
        let vc =  ActivityDetailViewController(delegate: self, activity: activity, index:indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
//        let cafeteria = cafeterias[indexPath.row]
//        let cell = tableView.cellForRow(at: indexPath) as! CafeteriaTableViewCell
//        cafeteria.isFavorite.toggle()
//        cell.toggleHeart(for: cafeteria.isFavorite)
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
//           let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//               self.songs.remove(at: indexPath.row)
//               tableView.reloadData()
//               success(true)
//           })
//           closeAction.image = UIImage(named: "tick")
//           closeAction.backgroundColor = .purple
//
//           return UISwipeActionsConfiguration(actions: [closeAction])
//    }
//
//    @objc func addSongViewControllerAndSaveText() {
//        // If let statements can also chain boolean checks after them, like a normal if statement.
//        // To dismiss something modally, we use the dismiss(animated:completion) command.
//        let vc = AddSongViewController(delegate: self)
//        navigationController?.pushViewController(vc, animated: true)
//
//    }

}


extension ActivityListController: AddRemoveDelegte{
    
    func addToPlan(index: Int, hours:Int){
        activities_pick.append((activities[index],hours))
        activities.remove(at: index)
        tableView.reloadData()
        current_plan.setTitle("Current Plan(\(activities_pick.count))", for:  UIControl.State.normal)
    }
    func addSongName(song_name:String, artists_name: String, album_name: String){
        return
    }
}
