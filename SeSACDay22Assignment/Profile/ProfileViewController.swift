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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    @objc func resignButtonTapped() {
        showAlert(title: "탈퇴하시겠습니까?", message: "모든 회원정보가 삭제되고\n회원가입화면으로 이동합니다.", button: "회원탈퇴", isCancelButton: true, buttonStyle: .destructive) {
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureView() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(resignButtonTapped))
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

        nicknameLabel.text = "NO NAME"
        nicknameLabel.textColor = .lightGray
        nicknameLabel.textAlignment = .right
        
        birthdayLabel.text = "NO DATE"
        birthdayLabel.textColor = .lightGray
        birthdayLabel.textAlignment = .right
        
        levelLabel.text = "NO LEVEL"
        levelLabel.textColor = .lightGray
        levelLabel.textAlignment = .right
    }
    
 
}

extension ProfileViewController: PassDataDelegate {
    func dateReceived(value: String) {
        birthdayLabel.text = value
    }
}
