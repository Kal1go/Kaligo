//
//  FilterCell.swift
//  Kaligo
//
//  Created by Matheus Silva on 04/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    @IBOutlet weak var filterButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filterButton.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }
    
    @objc func btnClicked (_ sender: UIButton) {
        filterButton.isSelected.toggle()
    }
    
}
