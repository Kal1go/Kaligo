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

    var textIsValid: Bool = true
    
//    var view: UIView
    
    weak var inputDelegate: InputDelegate?
    
    var type: InputType
    
    init(delegate: InputDelegate, type: InputType) {
//        self.view = view
        self.inputDelegate = delegate
        self.type = type
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
//           nextField.becomeFirstResponder()
//        } else {
//           textField.resignFirstResponder()
//        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textIsValid {
            guard let text = textField.text else { return }
            inputDelegate?.setText(for: textField.tag, with: text, type: type)
        }
    }
    
    private func validateText() {
        // validar o texto antes de enviar
    }
}
