//
//  List.swift
//  Kaligo
//
//  Created by Matheus Silva on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

struct List: Codable {
    var title: String
    var description: String
    var category: String
    var numberOfForks: Int
    var type: String
    var userID: String
    var steps: Steps?
    var _id: String?

    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "description": description,
            "category": category,
            "numberOfForks": numberOfForks,
            "type": type,
            "userID": userID,
            "steps": steps ?? [],
            "_id": _id ?? ""
        ]
    }
}

typealias Lists = [List]
