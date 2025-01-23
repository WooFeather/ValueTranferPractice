//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class LevelViewController: UIViewController {

    let segmentedControl = UISegmentedControl(items: ["상", "중", "하"])
    let segmentValue = [0: "상", 1: "중", 2: "하"]
    var receiveContents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ProfileViewController.isLevel = true
        saveValue()
    }
    
    @objc func okButtonTapped() {
        saveValue()
        ProfileViewController.isLevel = true
        navigationController?.popViewController(animated: true)
    }
    
    func saveValue() {
        guard let segValue = segmentValue[segmentedControl.selectedSegmentIndex] else { return }
        print(segValue)
        NotificationCenter.default.post(
            name: NSNotification.Name("LevelReceived"),
            object: nil,
            userInfo: [
                "level": segValue
            ]
        )
    }
    
    func configureView() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        if let receiveContents {
            segmentedControl.selectedSegmentIndex = segmentValue.findKey(forValue: receiveContents) ?? 0
        }
        
        // 이런식으로 타이틀에 접근해보기도 했으나, 정방향으로 값이 올때 대응할수가 없을거같아서 딕셔너리로 대체했습니다.
        // segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    // 이런식으로 타이틀에 접근해보기도 했으나, 정방향으로 값이 올때 대응할수가 없을거같아서 딕셔너리로 대체했습니다.
//    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
//        print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
//    }
}
