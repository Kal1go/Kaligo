//
//  UIViewController+Extentions.swift.swift
//  Kaligo
//
//  Created by Matheus Silva on 25/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

public extension UIViewController {
    func showCustomAlert(title: String,
                         message: String,
                         isOneButton: Bool,
                         withCompletion completion: @escaping (Bool) -> Void) {
        
        guard let customAlert = UIStoryboard(name: "CustomAlertView", bundle: nil)
            .instantiateViewController(withIdentifier: "CustomAlertID") as? CustomAlertView else {
            return
        }
        
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        
        customAlert.titleAlert = title
        customAlert.messageAlert = message
        customAlert.isOneButton = isOneButton
        customAlert.comfirmMoreDidTap { (answer) in
            completion(answer)
        }
        
        self.present(customAlert, animated: true, completion: nil)
    }
}
