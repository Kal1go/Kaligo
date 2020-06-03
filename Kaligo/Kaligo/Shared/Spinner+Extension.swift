//
//  LoginSpinnerView.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

extension UIView {
    func showSpinner() {
        DispatchQueue.main.async {
            let spinnerView = UIView.init(frame: self.bounds)
            spinnerView.backgroundColor =
                UIColor(named: "Background")?.withAlphaComponent(0.5) ??
                UIColor.white.withAlphaComponent(0.5)
            let animation = UIActivityIndicatorView.init(style: .medium)
            animation.startAnimating()
            animation.center = spinnerView.center
            spinnerView.tag = 999
            DispatchQueue.main.async {
                spinnerView.addSubview(animation)
                self.addSubview(spinnerView)
            }
        }
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            self.viewWithTag(999)?.removeFromSuperview()
        }
    }
}
