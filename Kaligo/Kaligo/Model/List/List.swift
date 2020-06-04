//
//  Playlist.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    case matematica = "Matemática"
    case portugues = "Língua Portuguesa"
    case biologia = "Biologia"
    case fisica = "Física"
    case quimica = "Química"
    case historia = "História"
    case geografica = "Geografia"
    case filosofia = "Filosofia"
    case sociologia = "Sociologia"
    case estrangeiras = "Língua estrangeira"
    case artes = "Artes"
    case outro = "Outro"
}

class List: Codable {
    var userName: String
    var userLevel: String
    var title: String
    var description: String
    var numberOfForks: Int
    var category: String
    var parent: String?
    var steps: Steps?
    var _id: String?
    var userID: String
    var type: String
    var hasForkedBy: [String]?
    var hasFork: Bool? = false
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "description": description,
            "category": category,
            "numberOfForks": numberOfForks,
            "type": type,
            "userName": userName,
            "userLevel": userLevel,
            "userID": CommonData.shared.user._id ?? "",
            "steps": steps?.dictionaryRepresentation() ?? [],
            "_id": _id ?? ""
        ]
    }
    
    var fork: [String: Any] {
        return [
            "userID": CommonData.shared.user._id ?? "",
            "listID": _id ?? ""
        ]
    }
    
    init() {
        self.userName = ""
        self.userLevel = ""
        self.userID = ""
        
        self.title = ""
        self.description = ""
        self.numberOfForks = 0
        self.category = ""
        self.type = ""
    }
    
    init(userName: String,
         userLevel: String,
         title: String,
         description: String,
         category: String,
         numberOfForks: Int,
         type: String) {
        self.userName = userName
        self.userLevel = userLevel
        self.userID = _id ?? ""
        
        self.title = title
        self.description = description
        self.numberOfForks = numberOfForks
        self.category = category
        self.type = type
    }
    
    static func delete(list: List) -> Lists {
        if var userList = CommonData.shared.user.list {
            guard let listId = CommonData.shared.user.list?.firstIndex(where: {$0._id == list._id}) else { return [] }
            userList.remove(at: listId)
            CommonData.shared.user.list = userList
            return userList
        } else {
            print("Error list not found")
            return []
        }
    }
    
    public func isOwner() -> Bool {
        if let userID = CommonData.shared.user._id {
            return self.userID == userID
        }
        return false
    }
    
    public func hasForked() -> Bool {
        if
            let userID = CommonData.shared.user._id,
            let forked = self.hasForkedBy {
            return forked.first(where: {$0 == userID}) != nil || self.hasFork ?? false
        }
        return false
    }
}

typealias Lists = [List]
