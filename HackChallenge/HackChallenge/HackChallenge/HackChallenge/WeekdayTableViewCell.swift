//
//  WeekdayTableViewCell.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/11/20.
//

import UIKit

class WeekdayTableViewCell: UITableViewCell {
    private let dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dayLabel.font = .boldSystemFont(ofSize: 40)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayLabel)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(for weekday: Day) {
        dayLabel.text = weekday.day
    }
}
