//
//  FoodViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/8/20.
//

import UIKit

class FoodViewController:UIViewController {
    private let userFoodTableView = UITableView()
    private let foodReuseIdentifier = "FoodReuseIdentifier"
    private let saveButton = UIButton()
    private let foodSearchBar = UISearchBar()
    private let totalCaloriesLabel = UILabel()
    
    private var userFoods:[UserFood] = []
    let placeholder1 = UserFood(userId: "Placeholder", foodId: 123, food:Food(foodId: 123, name: "Apple", calPerUnit: 5, unit: "grams"), timestamp: "12:55 P.M.", amount: 3)
    let placeholder2 = UserFood(userId: "Placeholder", foodId: 124, food: Food(foodId: 124, name: "Banana", calPerUnit: 5, unit: "grams"), timestamp: "1:00 P.M.", amount: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFoods = [placeholder1, placeholder2]
        
        title = "Healthy Eating"
        view.backgroundColor = .white
        userFoodTableView.delegate = self
        userFoodTableView.dataSource = self
        userFoodTableView.separatorStyle = .singleLine
        userFoodTableView.register(UserFoodTableViewCell.self, forCellReuseIdentifier: foodReuseIdentifier)
        userFoodTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userFoodTableView)
        
        totalCaloriesLabel.text = "Your total calories today: \(calculateTotalCalories(userFoods: userFoods))"
        totalCaloriesLabel.textColor = .black
        totalCaloriesLabel.textAlignment = .center
        totalCaloriesLabel.font = .systemFont(ofSize: 20)
        totalCaloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalCaloriesLabel)
        
        foodSearchBar.delegate = self
        foodSearchBar.backgroundColor = .white
        foodSearchBar.placeholder = "Enter Food"
        foodSearchBar.searchTextField.backgroundColor = .lightGray
        foodSearchBar.searchTextField.textColor = .black
        foodSearchBar.searchTextField.clearButtonMode = .whileEditing
        foodSearchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodSearchBar)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(dismissAndSave), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitleColor(.systemBlue, for: .normal)
        view.addSubview(saveButton)
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            userFoodTableView.topAnchor.constraint(equalTo: foodSearchBar.bottomAnchor, constant: 15),
            userFoodTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            userFoodTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totalCaloriesLabel.topAnchor.constraint(equalTo:userFoodTableView.bottomAnchor, constant: 5),
            totalCaloriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalCaloriesLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
        NSLayoutConstraint.activate([
            foodSearchBar.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 2),
            foodSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            foodSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            foodSearchBar.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        ])
    }
    
    @objc func dismissAndSave() {
        dismiss(animated: true, completion: nil)
        userFoodTableView.reloadData()
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
}

extension FoodViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFoods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: foodReuseIdentifier) as? UserFoodTableViewCell
        else {return UITableViewCell()}
        let userFood = userFoods[indexPath.row]
        cell.configure(for: userFood)
        return cell
    }
}

extension FoodViewController:UISearchBarDelegate {
    
}

