//
//  GaleriaViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class GaleriaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let codeSegmented = CustomSegmentedControl(
            frame: CGRect(
                x: 0,
                y: 50,
                width: self.view.frame.width,
                height: 50),
            buttonTitle: ["Playlists", "Dicas"])
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
    }

}
