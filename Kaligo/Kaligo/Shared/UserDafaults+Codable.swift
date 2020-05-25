//
//  UserDafaults+Codable.swift
//  Kaligo
//
//  Created by Matheus Silva on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

extension UserDefaults {

    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }

    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
