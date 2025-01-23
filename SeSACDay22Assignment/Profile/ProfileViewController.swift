//
//  ProfileViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    let nicknameButton = UIButton()
    let birthdayButton = UIButton()
    let levelButton = UIButton()
    
    let nicknameLabel = UILabel()
    let birthdayLabel = UILabel()
    let levelLabel = UILabel()
    
    static var isNickname = false
    static var isBirthday = false
    static var isLevel = false
    
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        receiveLevel()
        saveButtonReset()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        
        if ProfileViewController.isNickname == false || ProfileViewController.isBirthday == false || ProfileViewController.isLevel == false {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }

    @objc func resignButtonTapped() {
        showAlert(title: "탈퇴하시겠습니까?", message: "모든 회원정보가 삭제되고\n회원가입화면으로 이동합니다.", button: "회원탈퇴", isCancelButton: true, buttonStyle: .destructive) {
            // UserDefaults 값 삭제
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
            self.changeRootViewController(vc: OnboardingViewController(), isSigned: false)
        }
    }
    
    @objc private func nicknameButtonTapped() {
        let vc = NicknameViewController()
        vc.sendContents = { value in
            self.nicknameLabel.text = value
        }
        vc.receiveContents = nicknameLabel.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func birthdayButtonTapped() {
        let vc = BirthdayViewController()
        vc.sendContents = self
        vc.receiveContents = birthdayLabel.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func levelButtonTapped() {
        let vc = LevelViewController()
        vc.receiveContents = levelLabel.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        UserDefaultsManager.shared.nickname = nicknameLabel.text ?? "NO NAME"
        UserDefaultsManager.shared.birthday = birthdayLabel.text ?? "NO DATE"
        UserDefaultsManager.shared.level = levelLabel.text ?? "NO LEVEL"
        showAlert(title: "저장성공🥰", message: "성공적으로 저장되었습니다.", button: "확인") {
            self.dismiss(animated: true)
        }
    }
    
    @objc private func levelReceivedNotification(value: NSNotification) {
        if let level = value.userInfo!["level"] as? String {
            levelLabel.text = level
        } else {
            levelLabel.text = "NO LEVEL"
        }
    }
    
    private func receiveLevel() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(levelReceivedNotification),
            name: NSNotification.Name("LevelReceived"),
            object: nil
        )
    }
    
    private func saveButtonReset() {
        ProfileViewController.isNickname = false
        ProfileViewController.isBirthday = false
        ProfileViewController.isLevel = false
    }
    
    private func configureView() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(resignButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "저장하기", style: .plain, target: self, action: #selector(saveButtonTapped))
        view.backgroundColor = .white
        
        view.addSubview(nicknameButton)
        view.addSubview(birthdayButton)
        view.addSubview(levelButton)
        
        view.addSubview(nicknameLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(levelLabel)
        
        nicknameButton.addTarget(self, action: #selector(nicknameButtonTapped), for: .touchUpInside)
        birthdayButton.addTarget(self, action: #selector(birthdayButtonTapped), for: .touchUpInside)
        levelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }

        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }

        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        nicknameButton.setTitleColor(.black, for: .normal)
        birthdayButton.setTitleColor(.black, for: .normal)
        levelButton.setTitleColor(.black, for: .normal)
        
        nicknameButton.setTitle("닉네임", for: .normal)
        birthdayButton.setTitle("생일", for: .normal)
        levelButton.setTitle("레벨", for: .normal)

        nicknameLabel.text = UserDefaultsManager.shared.nickname
        nicknameLabel.textColor = .lightGray
        nicknameLabel.textAlignment = .right
        
        birthdayLabel.text = UserDefaultsManager.shared.birthday
        birthdayLabel.textColor = .lightGray
        birthdayLabel.textAlignment = .right
        
        levelLabel.text = UserDefaultsManager.shared.level
        levelLabel.textColor = .lightGray
        levelLabel.textAlignment = .right
    }
    
 
}

extension ProfileViewController: PassDataDelegate {
    func dateReceived(value: String) {
        birthdayLabel.text = value
    }
}
