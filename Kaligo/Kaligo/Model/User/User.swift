//
//  User.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
struct User: Codable {
    let _id: String?
    var email: String
    var appleID: String
    var name: String
    var level: String

    var dictionaryRepresentation: [String: Any] {
        return [
            "email": email,
            "name": name,
            "appleID": appleID,
            "level": level
        ]
    }
}

typealias Users = [User]
