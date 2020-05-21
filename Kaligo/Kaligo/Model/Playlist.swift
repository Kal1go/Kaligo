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
    case historia = "História"
    case biologia = "Biologia"
    case geografica = "Geografia"
    case portugues = "Português"
    case none
}

class ModeloPlaylist {
    var userName: String
    var userLevel: String
    var title: String
    var description: String
    var numberOfForks: Int
    var category: Category
    var steps: [ModeloPasso]
    
    init(userName: String, userLevel: String, title: String, description: String, category: Category, numberOfForks: Int) {
        self.userName = userName
        self.userLevel = userLevel
        self.title = title
        self.description = description
        self.numberOfForks = numberOfForks
        self.category = category
        steps = []
    }
    
    init() {
        self.userName = ""
        self.userLevel = ""
        self.title = ""
        self.description = ""
        self.numberOfForks = 0
        self.category = .none
        steps = []
    }
}
