//
//  UserFoodTableViewCell.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//

import UIKit

class UserFoodTableViewCell : UITableViewCell {
    private let nameLabel = UILabel()
    private let calLabel = UILabel()
    private let timestampLabel = UILabel()
    let padding:CGFloat = 5
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        selectionStyle = .none
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(nameLabel)
        
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.textColor = .black
        timestampLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(timestampLabel)
        
        calLabel.translatesAutoresizingMaskIntoConstraints = false
        calLabel.textColor = .black
        calLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(calLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
        NSLayoutConstraint.activate([
            timestampLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            timestampLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            calLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            calLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
    }
    
    func configure(for userFood: UserFood) {
        nameLabel.text = userFood.name
//        timestampLabel.text =
        calLabel.text = "\(userFood.food.cal * userFood.amount) calories"
    }
}

