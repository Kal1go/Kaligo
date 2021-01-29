//
//  ColorImage+Extensions.swift
//  Kaligo
//
//  Created by Matheus Silva on 04/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

extension UIColor {
    static var background: UIColor {
        return UIColor(named: "Background") ?? .white
    }
    static var tintMedium: UIColor {
        return UIColor(named: "Tint-Medium") ?? .white
    }
    static var tintLarge: UIColor {
        return UIColor(named: "Tint-Large") ?? .white
    }
    static var backgroundMedium: UIColor {
        return UIColor(named: "Clicavel") ?? .white
    }
}

extension UIImage {
    static var filterNotSelected: UIImage {
        return UIImage(named: "filtro_nao_selecionado") ?? UIImage()
    }
    static var filterSelected: UIImage {
        return UIImage(named: "filtro_selecionado") ?? UIImage()
    }
}

extension UIView {
    func gradientAction() {
        self.backgroundColor = .white
        let layer0 = CAGradientLayer()
        
        layer0.colors = [
            UIColor(red: 0.278, green: 0.212, blue: 0.973, alpha: 1).cgColor,
            
            UIColor(red: 0.302, green: 0.478, blue: 0.925, alpha: 1).cgColor
        ]
        
        layer0.locations = [0, 1]
        
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -2.05, b: -1, c: 0.99, d: -2.05, tx: 1.28, ty: 2.02))
        
        layer0.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width,
                                            dy: -0.5 * self.bounds.size.height)
        
        layer0.position = self.center
        
        self.layer.addSublayer(layer0)
    }
}

import UIKit

extension UIButton {
    
    enum Style {
        case card
        case circle
        case rounded
    }
    
    func setStyle(_ style: Style) {
        switch style {
        case .card:
            clipsToBounds = true
            layer.cornerRadius = 4
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowRadius = 12
            layer.shadowOpacity = 0.16
        case .circle:
            clipsToBounds = true
            let radius = frame.height / 2
            layer.cornerRadius = radius
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowRadius = 4
            layer.shadowOpacity = 0.25
            layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        case .rounded:
            clipsToBounds = true
            layer.cornerRadius = frame.height / 2
        }
    }
    
}
