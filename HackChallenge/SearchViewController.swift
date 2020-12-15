//
//  SearchViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/12/20.
//

import UIKit

class SearchViewController: UIViewController {
    private let foodNameLabel = UILabel()
    private let calPerUnitLabel = UILabel()
    private let amountField = UITextField()
    private let addButton = UIButton()
    weak var delegate:addFoodDelegate?
    var food:Food
    
    init(delegate:addFoodDelegate, food: Food) {
        self.delegate = delegate
        self.food = food
        super.init(nibName: nil, bundle: nil)
        foodNameLabel.text = food.name
        calPerUnitLabel.text = "\(food.cal) calories per \(food.unit)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        foodNameLabel.font = .boldSystemFont(ofSize: 30)
        foodNameLabel.textColor = .black
        foodNameLabel.textAlignment = .center
        foodNameLabel.isUserInteractionEnabled = false
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodNameLabel)
        
        calPerUnitLabel.font = .systemFont(ofSize: 20)
        calPerUnitLabel.textColor = .black
        calPerUnitLabel.textAlignment = .center
        calPerUnitLabel.isUserInteractionEnabled = false
        calPerUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calPerUnitLabel)
        
        amountField.clearsOnBeginEditing = true
        amountField.isUserInteractionEnabled = true
        amountField.placeholder = "Enter Amount Eaten"
        amountField.textColor = .black
        amountField.borderStyle = .roundedRect
        amountField.backgroundColor = .lightGray
        amountField.clearButtonMode = .whileEditing
        amountField.font = .systemFont(ofSize: 30)
        amountField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountField)
        
        addButton.setTitle("Add Food", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 20)
        addButton.addTarget(self, action: #selector(addAndDismiss), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            foodNameLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            foodNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            calPerUnitLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 15),
            calPerUnitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            amountField.topAnchor.constraint(equalTo: calPerUnitLabel.bottomAnchor, constant: 15),
            amountField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
        ])
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 15),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func addAndDismiss() {
        if amountField.text!.count == 0 {
            dismiss(animated: true, completion: nil)
        }
        if let amount = Int(amountField.text ?? "0") {
            delegate?.addFood(amount: amount, food: food)
            dismiss(animated: true, completion: nil)
        }
    }
}


