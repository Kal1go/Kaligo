//
//  Step.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

class ModeloPasso {
    var title: String
    var description: String
    var url: String
    var number: Int
    
    init(number: Int) {
        self.title = ""
        self.description = ""
        self.url = ""
        self.number = number
    }
}
