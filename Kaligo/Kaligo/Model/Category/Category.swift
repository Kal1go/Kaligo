//
//  Category.swift
//  Kaligo
//
//  Created by Matheus Silva on 04/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    case artes = "Artes"
    case biologia = "Biologia"
    case filosofia = "Filosofia"
    case fisica = "Física"
    case geografica = "Geografia"
    case historia = "História"
    case estrangeiras = "Língua estrangeira"
    case portugues = "Língua Portuguesa"
    case matematica = "Matemática"
    case quimica = "Química"
    case sociologia = "Sociologia"
    case outro = "Outro"
}

typealias Categories = [Category]

extension Categories {
    static func getCategories() -> [String] {
        return Category.allCases.map { (value) in
            value.rawValue
        }
    }
}
