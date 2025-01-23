//
//  UserDefaultsManager.swift
//  SeSACDay22Assignment
//
//  Created by 조우현 on 1/23/25.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    var isSigned: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isSigned")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSigned")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? "NO NAME"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var birthday: String {
        get {
            UserDefaults.standard.string(forKey: "birthday") ?? "NO DATE"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "birthday")
        }
    }
    
    var level: String {
        get {
            UserDefaults.standard.string(forKey: "level") ?? "NO LEVEL"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "level")
        }
    }
}
