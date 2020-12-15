//
//  FoodViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/8/20.
//

import UIKit

class FoodViewController:UIViewController {
    private let totalCaloriesLabel = UILabel()
    private let tableLabel = UILabel()
    private let foodSearchBar = UISearchBar()
    
    private let searchFoodTableView = UITableView()
    private let searchReuseIdentifier = "SearchReuseIdentifier"
    private var searchResults:[Food] = [Food(foodId: 123, name: "Apple", calPerUnit: 5, unit: "grams")]
    
    private let userFoodTableView = UITableView()
    private let foodReuseIdentifier = "FoodReuseIdentifier"

    private var userFoods:[UserFood] = []
    
    let placeholder1 = UserFood(userId: "Placeholder", foodId: 123, food:Food(foodId: 123, name: "Apple", calPerUnit: 5, unit: "grams"), timestamp: "12:55 P.M.", amount: 3)
    let placeholder2 = UserFood(userId: "Placeholder", foodId: 124, food: Food(foodId: 124, name: "Banana", calPerUnit: 5, unit: "grams"), timestamp: "1:00 P.M.", amount: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFoods = [placeholder1, placeholder2]
        
        title = "Food"
        view.backgroundColor = .white
        totalCaloriesLabel.text = "Your total calories today: \(calculateTotalCalories(userFoods: userFoods))"
        totalCaloriesLabel.textColor = .black
        totalCaloriesLabel.textAlignment = .center
        totalCaloriesLabel.font = .systemFont(ofSize: 20)
        totalCaloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalCaloriesLabel)
        
        searchFoodTableView.delegate = self
        searchFoodTableView.dataSource = self
        searchFoodTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: searchReuseIdentifier)
        searchFoodTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchFoodTableView)
        
        tableLabel.text = "Today's Food"
        tableLabel.font = .boldSystemFont(ofSize: 24)
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableLabel)
        
        userFoodTableView.delegate = self
        userFoodTableView.dataSource = self
        userFoodTableView.separatorStyle = .singleLine
        userFoodTableView.register(UserFoodTableViewCell.self, forCellReuseIdentifier: foodReuseIdentifier)
        userFoodTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userFoodTableView)
        
        foodSearchBar.delegate = self
        foodSearchBar.backgroundColor = .white
        foodSearchBar.placeholder = "Enter Food"
        foodSearchBar.searchTextField.backgroundColor = .lightGray
        foodSearchBar.searchTextField.textColor = .black
        foodSearchBar.searchTextField.clearButtonMode = .whileEditing
        foodSearchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodSearchBar)
        setUpConstraints()
        }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            foodSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            foodSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            foodSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            searchFoodTableView.topAnchor.constraint(equalTo: foodSearchBar.bottomAnchor),
            searchFoodTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchFoodTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchFoodTableView.bottomAnchor.constraint(equalTo: tableLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            tableLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userFoodTableView.topAnchor.constraint(equalTo: tableLabel.bottomAnchor, constant: 5),
            userFoodTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userFoodTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totalCaloriesLabel.topAnchor.constraint(equalTo:userFoodTableView.bottomAnchor, constant: 5),
            totalCaloriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalCaloriesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
    
    func calculateTotalCalories(userFoods: [UserFood])-> Int {
        var totalCalories:Int = 0
        for item in userFoods {
            totalCalories += item.amount * item.food.calPerUnit
        }
        return totalCalories
    }
}

extension FoodViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == searchFoodTableView {
//            let searchView = SearchViewController()
//            present(searchView, animated: true, completion: nil)
//        }
//    }
}

extension FoodViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case userFoodTableView:
            return userFoods.count
        case searchFoodTableView:
            return searchResults.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case userFoodTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: foodReuseIdentifier) as? UserFoodTableViewCell
            else {return UITableViewCell()}
            let userFood = userFoods[indexPath.row]
            cell.configure(for: userFood)
            return cell
        case searchFoodTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: searchReuseIdentifier) as? SearchTableViewCell
            else {return UITableViewCell()}
            let result = searchResults[indexPath.row]
            cell.configure(for: result)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension FoodViewController:UISearchBarDelegate {
    
}
