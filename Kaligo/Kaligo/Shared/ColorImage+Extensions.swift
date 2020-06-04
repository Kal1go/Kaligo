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
