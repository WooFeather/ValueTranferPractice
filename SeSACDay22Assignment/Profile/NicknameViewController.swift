//
//  NicknameViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class NicknameViewController: UIViewController {

    private let textField = UITextField()
    var sendContents: ((String) -> Void)?
    var receiveContents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveValue()
        ProfileViewController.isNickname = true
    }
    
    @objc func okButtonTapped() {
        saveValue()
        ProfileViewController.isNickname = true
        navigationController?.popViewController(animated: true)
    }
    
    private func saveValue() {
        guard let text = textField.text else { return }
        
        let trimmingText = text.trimmingCharacters(in: .whitespaces)
        if trimmingText.isEmpty {
            showAlert(title: "닉네임 저장 실패!", message: "닉네임은 최소 한글자 이상 입력해주세요.", button: "확인") {
                self.dismiss(animated: true)
            }
        } else {
            sendContents?(trimmingText)
        }
    }
    
    func configureView() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        textField.placeholder = "닉네임을 입력해주세요"
        textField.text = receiveContents ?? ""
    }
}
