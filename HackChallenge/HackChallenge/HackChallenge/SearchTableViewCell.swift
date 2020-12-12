//
//  SearchTableViewCell.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/11/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    private let foodLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        foodLabel.font = .systemFont(ofSize: 16)
        foodLabel.textColor = .systemBlue
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(foodLabel)
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            foodLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func configure(for food: Food) {
        foodLabel.text = food.name
    }
}
