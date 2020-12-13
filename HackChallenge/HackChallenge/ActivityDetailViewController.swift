//
//  ActivityDetailViewController.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/7/20.
//
import UIKit

class ActivityDetailViewController: UIViewController {
    
    var activity: Activity?
    var activity_name: UITextField!
    var activity_label: UILabel!
    var button: UIButton!
    var index: Int!
    weak var delegate: AddRemoveDelegte?
    
    var cal_perField: UITextField!
    var cal_perhourLabel: UILabel!
    
    
    var hourField: UITextField!
    var hour_Label: UILabel!

    init(delegate: AddRemoveDelegte?, activity:Activity?, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.activity = activity
        self.index = index
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        activity_name = UITextField()
        activity_name.translatesAutoresizingMaskIntoConstraints = false
        activity_name.text = activity?.name
        activity_name.borderStyle = .roundedRect
        activity_name.backgroundColor = .white
        activity_name.textAlignment = .center
        activity_name.clearsOnBeginEditing = true
        activity_name.isUserInteractionEnabled = false
        view.addSubview(activity_name)
        
        
        cal_perField = UITextField()
        cal_perField.translatesAutoresizingMaskIntoConstraints = false
        cal_perField.text = String(activity!.cal)
        cal_perField.borderStyle = .roundedRect
        cal_perField.backgroundColor = .white
        cal_perField.textAlignment = .center
        cal_perField.clearsOnBeginEditing = true
        cal_perField.isUserInteractionEnabled = false
        view.addSubview(cal_perField)
        
        hourField = UITextField()
        hourField.translatesAutoresizingMaskIntoConstraints = false
        hourField.text = "0"
        hourField.borderStyle = .roundedRect
        hourField.backgroundColor = .white
        hourField.textAlignment = .center
        hourField.clearsOnBeginEditing = true
        view.addSubview(hourField)
        
        activity_label = UILabel()
        activity_label.translatesAutoresizingMaskIntoConstraints = false
        activity_label.text = "Activity Name"
        activity_label.textAlignment = .center
        view.addSubview(activity_label)
        
        cal_perhourLabel = UILabel()
        cal_perhourLabel.translatesAutoresizingMaskIntoConstraints = false
        cal_perhourLabel.text = "Cal Consumption Per Hour"
        cal_perhourLabel.textAlignment = .center
        view.addSubview(cal_perhourLabel)
        
        hour_Label = UILabel()
        hour_Label.translatesAutoresizingMaskIntoConstraints = false
        hour_Label.text = "Input the time you spent on this \(activity!.name)"
        hour_Label.textAlignment = .center
        view.addSubview(hour_Label)
        
        
        button = UIButton(type: UIButton.ButtonType.detailDisclosure)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm change and Exit", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissViewControllerAndSaveText), for: .touchUpInside)
        view.addSubview(button)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // textField constraints
        // button constraints
        
        NSLayoutConstraint.activate([
            activity_label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            activity_label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            activity_label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            activity_label.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            activity_name.topAnchor.constraint(equalTo: activity_label.bottomAnchor, constant: 12),
            activity_name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            activity_name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            activity_name.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            cal_perhourLabel.topAnchor.constraint(equalTo:  activity_name.bottomAnchor, constant: 24),
            cal_perhourLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cal_perhourLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cal_perhourLabel.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            cal_perField.topAnchor.constraint(equalTo:  cal_perhourLabel.bottomAnchor, constant: 12),
            cal_perField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cal_perField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cal_perField .heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            hour_Label.topAnchor.constraint(equalTo: cal_perField.bottomAnchor, constant: 24),
            hour_Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            hour_Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            hour_Label.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            hourField.topAnchor.constraint(equalTo:  hour_Label.bottomAnchor, constant: 12),
            hourField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            hourField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            hourField .heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: hourField.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 48)
            ])
    }
    
    @objc func dismissViewControllerAndSaveText() {
        // If let statements can also chain boolean checks after them, like a normal if statement.
        // To dismiss something modally, we use the dismiss(animated:completion) command.
        
//        if let text = textField.text, text.trimmingCharacters(in: .whitespaces).isEmpty {
//            // string contains non-whitespace characters
//            showSimpleAlert()
//            return
//        }
//
        if let hours =  Int(hourField.text!) {
            // Here, we're delegating someone to handle when the button title has changed
            // We don't know if anyone heard, but if they did, they should handle it
            // The method for textFieldTextChanged(to:) is in ViewController.
            delegate?.addToPlan(index: index, hours: hours)
        }
        navigationController?.popViewController(animated: true)
    }
}
