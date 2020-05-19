//
//  PlaylistTableViewCell.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 15/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var forkButton: UIImageView!
    
    @IBOutlet weak var numberOfForks: UILabel!
    
    @IBOutlet weak var playlistTitle: UILabel!
    
    @IBOutlet weak var playlistDescription: UILabel!
    
    @IBOutlet weak var playlistCategory: UILabel!
    
    @IBOutlet weak var userLevel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
