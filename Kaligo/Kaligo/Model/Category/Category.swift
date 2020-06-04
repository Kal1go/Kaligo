//
//  Category.swift
//  Kaligo
//
//  Created by Matheus Silva on 04/06/20.
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

typealias Categories = [Category]

extension Categories {
    static func getCategories() -> [String] {
        return Category.allCases.map { (value) in
            value.rawValue
        }
    }
}
