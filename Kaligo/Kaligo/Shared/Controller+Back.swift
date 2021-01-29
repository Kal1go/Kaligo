//
//  Controller+Back.swift
//  Kaligo
//
//  Created by Matheus Silva on 22/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

extension UIViewController {
    func back() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UINavigationController {
    var previousViewController: UIViewController? {
        return viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}
