//
//  CommonData.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

class CommonData {
    static var shared = CommonData()
    private init() {}
    
    var user: User {
        get {
            return UserDefaults.standard.value(User.self, forKey: "user")!
        }
        set {
            UserDefaults.standard.set(encodable: newValue, forKey: "user")
        }
    }
    
    static var isSawOndoarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isSawOndoarding")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSawOndoarding")
        }
    }
    
    static var isLogged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLogged")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLogged")
        }
    }
}
