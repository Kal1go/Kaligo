//
//  ServerAnswer.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

public struct ServerAnswer<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var content: T?
}
