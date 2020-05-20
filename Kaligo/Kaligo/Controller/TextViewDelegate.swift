//
//  TextViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 20/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class TextViewDelegate: NSObject, UITextViewDelegate {
    
    weak var inputDelegate: InputDelegate?
    
    var type: InputType
    
    init(delegate: InputDelegate, type: InputType) {
        self.inputDelegate = delegate
        self.type = type
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if validateText() {
            guard let text = textView.text else { return }
            inputDelegate?.setText(for: textView.tag, with: text, type: type)
        }
    }
    
    private func validateText() -> Bool {
        // validar o texto antes de enviar
        return true
    }
    
}
