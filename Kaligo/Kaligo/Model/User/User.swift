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
    var list: Lists?

    var dictionaryRepresentation: [String: Any] {
        return [
            "email": email,
            "name": name,
            "appleID": appleID,
            "level": level
        ]
    }
    static func addlist(list: List) {
        if var userList = CommonData.shared.user.list {
            userList.append(list)
            CommonData.shared.user.list = userList
        } else {
            CommonData.shared.user.list = [list]
        }
    }
    static func updatelist(list: List) {
        if var userList = CommonData.shared.user.list {
            if let index = userList.firstIndex(where: {$0._id == list._id}) {
                userList[index] = list
                CommonData.shared.user.list = userList
            }
            
        } else {
            CommonData.shared.user.list = [list]
        }
    }
    static func find(withId _id: String?) -> List? {
        if let userList = CommonData.shared.user.list {
            if let index = userList.firstIndex(where: {$0._id == _id}) {
                return userList[index]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

typealias Users = [User]
