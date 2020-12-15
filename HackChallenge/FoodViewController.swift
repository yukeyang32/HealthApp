//
//  FoodViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/8/20.
//

import UIKit

protocol addFoodDelegate: class {
    func addFood(amount:Int,food:Food)
}

class FoodViewController:UIViewController {
    var date:Date
    let year:Int
    let month:Int
    let day:Int
    private let totalCaloriesLabel = UILabel()
    private let tableLabel = UILabel()
    private let submitButton = UIButton()
    private let foodSearchBar = UISearchBar()
    
    private let searchFoodTableView = UITableView()
    private let searchReuseIdentifier = "SearchReuseIdentifier"
    
    private let userFoodTableView = UITableView()
    private let foodReuseIdentifier = "FoodReuseIdentifier"

    private var searchResults:[Food] = []
    private var userEatenFoods:[UserFood] = []
    
    init(date: Date) {
        self.date = date
        self.year = Calendar.current.component(.year, from: date)
        self.month = Calendar.current.component(.month, from: date)
        self.day = Calendar.current.component(.day, from: date)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Food"
        view.backgroundColor = .white
        getFoodUserByDate(userId: 1)
        foodSearchBar.delegate = self
        foodSearchBar.backgroundColor = .white
        foodSearchBar.placeholder = "Enter Food"
        foodSearchBar.autocapitalizationType = .none
        foodSearchBar.searchTextField.backgroundColor = .lightGray
        foodSearchBar.searchTextField.textColor = .black
        foodSearchBar.searchTextField.clearButtonMode = .whileEditing
        foodSearchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodSearchBar)
        
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
        
        submitButton.setTitle("Save Changes", for: .normal)
        submitButton.setTitleColor(.systemBlue, for: .normal)
        submitButton.addTarget(self, action: #selector(saveAndDismiss), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
//        totalCaloriesLabel.text = "Your total calories: \(calcTotalCalories(userFoods: userEatenFoods))"
        totalCaloriesLabel.textColor = .black
        totalCaloriesLabel.textAlignment = .center
        totalCaloriesLabel.font = .systemFont(ofSize: 20)
        totalCaloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.updateTotalCalories()
        view.addSubview(totalCaloriesLabel)
    
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
            submitButton.topAnchor.constraint(equalTo: userFoodTableView.bottomAnchor, constant: 5),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totalCaloriesLabel.topAnchor.constraint(equalTo:submitButton.bottomAnchor, constant: 5),
            totalCaloriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalCaloriesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
    
    func calcTotalCalories(userFoods: [UserFood]) -> Int {
        var totalCalories:Int = 0
        for eachFood in userFoods {
            NetworkManager.getFoodByName(foodName: eachFood.name) { food in
                totalCalories += eachFood.amount * food.cal
            }
        }
        return totalCalories
    }
    
    @objc func saveAndDismiss() {
        addFoodToUser(userFoodList: userEatenFoods)
        navigationController?.popViewController(animated: true)
    }
    
    func updateTotalCalories() {
        let totalCalories = self.calcTotalCalories(userFoods: self.userEatenFoods)
        self.totalCaloriesLabel.text = "Your total calories: \(totalCalories)"
    }
}

extension FoodViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == searchFoodTableView) {
            let searchView = SearchViewController(delegate: self, food: searchResults[indexPath.row])
            present(searchView, animated: true, completion: nil)
        }
    }
}

extension FoodViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case userFoodTableView:
            return userEatenFoods.count
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
            let userFood = userEatenFoods[indexPath.row]
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        NetworkManager.getFoodByName(foodName: searchBar.text ?? "") { food in
            self.searchResults = [food]
            DispatchQueue.main.async {
                self.searchFoodTableView.reloadData()
            }
        }
    }
}

extension FoodViewController:addFoodDelegate {
    func addFood(amount: Int, food: Food) {
        let newFood = UserFood(id: food.id, userid: 1, name: food.name, year: year, month: month, day: day, amount: amount)
        userEatenFoods.append(newFood)
        DispatchQueue.main.async {
            self.userFoodTableView.reloadData()
        }
    }
}

extension FoodViewController {
    
    func addFoodToUser(userFoodList: [UserFood]) {
        for foods in userFoodList {
            NetworkManager.getFoodByName(foodName: foods.name) { food in
                NetworkManager.addFoodToUser(food: food, amount: foods.amount, date: self.date) { _ in
                }
            }
        }
    }
    func getFoodUserByDate(userId: Int) {
        NetworkManager.getFoodUserByDate(userId: userId, date: date) { dateFoods in
            self.userEatenFoods = dateFoods
            DispatchQueue.main.async {
                self.userFoodTableView.reloadData()
                self.totalCaloriesLabel.text = "Your total calories: \(self.calcTotalCalories(userFoods: self.userEatenFoods))"
            }
        }
    }
}
