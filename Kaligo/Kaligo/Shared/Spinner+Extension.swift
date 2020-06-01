//
//  LoginSpinnerView.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

var vSpinner: UIView?

extension UIView {
    func showSpinner() {
        let spinnerView = UIView.init(frame: self.bounds)
        spinnerView.backgroundColor =
            UIColor(named: "Background")?.withAlphaComponent(0.5) ??
            UIColor.white.withAlphaComponent(0.5)
        let animation = UIActivityIndicatorView.init(style: .medium)
        animation.startAnimating()
        animation.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(animation)
            self.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
