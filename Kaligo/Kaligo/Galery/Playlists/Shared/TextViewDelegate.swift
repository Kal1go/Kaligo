//
//  TextViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 20/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class TextViewDelegate: NSObject, UITextViewDelegate {
    
    let placeholder = "Descrição"
    
    var type: InputType
    
    weak var inputDelegate: InputDelegate?
    
    init(delegate: InputDelegate, type: InputType) {
        self.inputDelegate = delegate
        self.type = type
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = UIColor(named: "Cor-LetraEscura")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if validateText(for: textView) {
            guard let text = textView.text else { return }
            inputDelegate?.setText(for: textView.tag, with: text, type: type)
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func setTextView(_ textView: UITextView, with text: String = "") {
        if text != "" {
            textView.text = text
            textView.textColor = UIColor(named: "Tint")
        } else {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
        
    }
    
    private func validateText(for textView: UITextView) -> Bool {
        if let text = textView.text {
            if text != "" {
                return true
            }
        }
        return false
    }
    
}
