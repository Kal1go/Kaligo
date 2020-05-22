//
//  Step.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

class Step: Codable {
    var title: String
    var description: String
    var url: String
    var number: Int
    var _id: String?
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "description": description,
            "url": url,
            "_id": _id ?? ""
        ]
    }
    
    init(number: Int) {
        self.title = ""
        self.description = ""
        self.url = ""
        self.number = number
    }
}

typealias Steps = [Step]
