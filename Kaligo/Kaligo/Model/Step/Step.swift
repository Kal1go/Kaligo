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
    var isExpanded: Bool? = false
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "description": description,
            "url": url,
            "number": number,
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

extension Steps {
    func dictionaryRepresentation() -> String? {
        var setpsRepresentation: [[String: Any]] = []
        self.forEach({ (step) in
            setpsRepresentation.append(step.dictionaryRepresentation)
        })
        guard let data = try? JSONSerialization.data(withJSONObject: setpsRepresentation, options: .prettyPrinted) else { return "" }

        return String(data: data, encoding: String.Encoding.utf8) ?? ""
    }
}
