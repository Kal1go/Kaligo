//
//  AutoResizeLabel.swift
//  Kaligo
//
//  Created by Matheus Silva on 04/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class AutoResizeLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.sizeToFit()
    }
}
