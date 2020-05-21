//
//  Step.swift
//  Kaligo
//
//  Created by Matheus Silva on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

struct Step: Codable {
    var title: String
    var description: String
    var url: String
    var _id: String?

    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "description": description,
            "url": url,
            "_id": _id ?? ""
        ]
    }
}

typealias Steps = [Step]
