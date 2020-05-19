//
//  LoginExtensions.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import AuthenticationServices

extension String {
    func getFirst() -> String {
        return components(separatedBy: .whitespaces)[0]
    }
}

extension PersonNameComponents {
    func getFullName() -> String {
        let given = givenName ?? ""
        let family = familyName ?? ""
        return given + " " + family
    }
}
