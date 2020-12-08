//
//  ViewController.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//

import UIKit

class ViewController: UIViewController {
    private let foodButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        foodButton.setTitle("User Food", for: .normal)
        foodButton.titleLabel?.font = .systemFont(ofSize: 40)
        foodButton.setTitleColor(.black, for: .normal)
        foodButton.translatesAutoresizingMaskIntoConstraints = false
        foodButton.addTarget(self, action: #selector(presentFoodView), for: .touchUpInside)
        view.addSubview(foodButton)
        setUpConstraints()
        
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            foodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            foodButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func presentFoodView() {
        let foodView = FoodViewController()
        present(foodView, animated: true, completion: nil)
    }
}
