//
//  PlanTableViewCell.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/7/20.
//
import UIKit

class PlanTableViewCell: UITableViewCell {
    var activity_name: UITextField!
    var hour:Int!
    var cal_per_hour: Int!
    var heartImageView: UIImageView!
    var image_address:String!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.backgroundColor = .white
        activity_name = UITextField()
        activity_name.translatesAutoresizingMaskIntoConstraints = false
        activity_name.font = .systemFont(ofSize: 14)
        activity_name.isUserInteractionEnabled = false
        contentView.addSubview(activity_name)


        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

        let padding: CGFloat = 8
//        let heartImageWidth: CGFloat =  100
        let labelHeight: CGFloat = 50

        NSLayoutConstraint.activate([
            activity_name .leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            activity_name .topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            activity_name .heightAnchor.constraint(equalToConstant: labelHeight)
        ])

    }

    func configure(for act: (Activity,Int)) {

        hour = act.1
        cal_per_hour = act.0.cal
        activity_name.text = "\(act.0.name) + \(hour!) hours  consume \(hour * cal_per_hour) cal"
    }

}
