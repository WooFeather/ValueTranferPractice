//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class BirthdayViewController: UIViewController {

    let datePicker = UIDatePicker()
    
    var sendContents: PassDataDelegate?
    var receiveContents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(datePicker.date)
        sendContents?.dateReceived(value: datePicker.date.toString())
    }
    
    @objc func okButtonTapped() {
        sendContents?.dateReceived(value: datePicker.date.toString())
        print(datePicker.date)
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.date = receiveContents?.toDate() ?? Date()
    }
}
