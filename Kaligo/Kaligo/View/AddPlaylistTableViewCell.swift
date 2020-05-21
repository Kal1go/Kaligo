//
//  CriarPlaylistTableViewCell.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class AddPlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func addPlaylist(_ sender: Any) {
        print("Cria playlist")
    }

}
