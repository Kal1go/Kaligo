//
//  HomeTableViewCell.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class CategoriasHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nomeCategoriaCardHome: UILabel!
    @IBOutlet weak var numeroPlaylistCardHomw: UILabel!
    @IBOutlet weak var imageCategoriaCardHome: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
