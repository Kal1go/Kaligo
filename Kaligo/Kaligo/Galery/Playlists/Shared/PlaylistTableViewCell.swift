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
    @IBOutlet weak var playlistTitle: UILabel!
    @IBOutlet weak var playlistDescription: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var forkButton: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    
    private var imageForkS = UIImage(named: "botao-fork-selecionado")
    private var imageFork = UIImage(named: "botao-fork")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height / 2
        profilePicture.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(playlist: List, indexPath: IndexPath) {
        self.userName.text = playlist.userName != " " ? playlist.userName : "Anônimo"
        self.userLevel.text = "Nível \(playlist.numberOfForks)"
        self.playlistTitle.text = playlist.title
        self.playlistDescription.text = playlist.description
        self.forkButton.tag = indexPath.row
        self.categoryImage.image = UIImage(named: "\(playlist.category)")
        
        let isForked = playlist.isOwner() || playlist.hasForked()
        self.forkButton.setImage(isForked ? imageForkS : imageFork, for: .normal)
        self.forkButton.isEnabled = !isForked
    }
}
