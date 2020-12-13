//
//  ActivityTableViewCell.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/6/20.
//
import UIKit

class ActivityTableViewCell: UITableViewCell {
    var activity_name: UITextField!
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

        heartImageView = UIImageView()
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.isHidden = false
        contentView.addSubview(heartImageView)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

        let padding: CGFloat = 8
        let heartImageWidth: CGFloat =  100
        let labelHeight: CGFloat = 50

        NSLayoutConstraint.activate([
            activity_name .leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            activity_name .topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            activity_name .heightAnchor.constraint(equalToConstant: labelHeight)
        ])

        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(equalToConstant: heartImageWidth),
            heartImageView.widthAnchor.constraint(equalToConstant: heartImageWidth),
            heartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            heartImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(for act: Activity) {
        activity_name.text = act.name
        heartImageView.image = UIImage(named: "swimming")
    }

}
