//
//  PostsViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 15/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var playlistsTableView: UITableView!

    // TODO: delegate deve ser weak
    var collectionViewDelegate: FilterCollectionViewDelegate?
    var tableViewDelegate: PlaylistTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionViewDelegate = FilterCollectionViewDelegate()
        collectionViewDelegate?.categories = ["Matemática", "História", "Geografia", "Biologia"]

        filterCollectionView.delegate = self.collectionViewDelegate
        filterCollectionView.dataSource = self.collectionViewDelegate

        self.tableViewDelegate = PlaylistTableViewDelegate()
        tableViewDelegate?.playlists = [ModeloPlaylist(userName: "Jaque",
                                                       userLevel: "Nível 7",
                                                       title: "Álgebra",
                                                       description: "Descrição dessa playlist",
                                                       category: "Categoria",
                                                       numberOfForks: 36)]

        playlistsTableView.delegate = tableViewDelegate
        playlistsTableView.dataSource = tableViewDelegate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
