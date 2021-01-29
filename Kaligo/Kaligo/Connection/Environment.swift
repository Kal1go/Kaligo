//
//  Environment.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

struct Environment {
    // MARK: - State
    private static let PRODUCTION = true

    // MARK: - Server
    public static var SERVER_URL: String {
        return PRODUCTION ?
            "https://kaligo.herokuapp.com/api" : "http://localhost:3000/api"
    }

    // MARK: - IMAGE
    public static let IMAGE_URL_SERVER = "https://kaligo-image.herokuapp.com/"

    public static let IMAGE_ACCESS_CODE = "qrH9hy1SFind9iGLhEkykCH7Rp7jpRDq"
}
