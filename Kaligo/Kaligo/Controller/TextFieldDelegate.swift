//
//  TextFieldDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 20/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

enum InputType {
    case title
    case description
    case url
}

protocol InputDelegate: class {
    func setText(for index: Int, with text: String, type: InputType)
}

class TextFieldDelegate: NSObject, UITextFieldDelegate {
        
    weak var inputDelegate: InputDelegate?
    
    var type: InputType
    
    init(delegate: InputDelegate, type: InputType) {
        self.inputDelegate = delegate
        self.type = type
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if validateText(for: textField) {
            guard let text = textField.text else { return }
            inputDelegate?.setText(for: textField.tag, with: text, type: type)
        }
    }
    
    private func validateText(for textField: UITextField) -> Bool {
        if let text = textField.text {
            if text != "" {
                return true
            }
        }
        return false
    }
}
