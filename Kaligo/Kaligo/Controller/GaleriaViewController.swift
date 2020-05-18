//
//  GaleriaViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class GaleriaViewController: UIViewController {

    @IBOutlet weak var playlistsOptionImage: UIImageView!
    @IBOutlet weak var tipsOptionImage: UIImageView!
    @IBOutlet weak var playlistsTableView: UITableView!
    
    // TODO: delegate deve ser weak
    var tableViewDelegate: GaleryPlaylistsTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewDelegate = GaleryPlaylistsTableViewDelegate()
        tableViewDelegate?.playlists = [ModeloPlaylist(userName: "Jaque",
                                                       userLevel: "Nível 7",
                                                       title: "Álgebra",
                                                       description: "Descrição dessa playlist",
                                                       category: "Categoria",
                                                       numberOfForks: 36)]
        
        playlistsTableView.delegate = tableViewDelegate
        playlistsTableView.dataSource = tableViewDelegate
        
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        if sender.tag == 1 {
            playlistsOptionImage.tintColor = UIColor(named: "Clicavel")
            tipsOptionImage.tintColor = UIColor(named: "Background")
        } else {
            tipsOptionImage.tintColor = UIColor(named: "Clicavel")
            playlistsOptionImage.tintColor = UIColor(named: "Background")
        }
    }
}
