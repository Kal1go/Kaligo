//
//  TextFild+Return.swift
//  Kaligo
//
//  Created by Matheus Silva on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

extension UITextField {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
