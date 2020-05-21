//
//  Playlist.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

class ModeloPlaylist {
    var userName: String
    var userLevel: String
    var title: String
    var description: String
    var category: String
    var numberOfForks: Int
    var steps: [ModeloPasso]
    
    init(userName: String, userLevel: String, title: String, description: String, category: String, numberOfForks: Int) {
        self.userName = userName
        self.userLevel = userLevel
        self.title = title
        self.description = description
        self.category = category
        self.numberOfForks = numberOfForks
        steps = []
    }
    
    init() {
        self.userName = ""
        self.userLevel = ""
        self.title = ""
        self.description = ""
        self.category = ""
        self.numberOfForks = 0
        steps = []
    }
}
