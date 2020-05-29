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

    var collectionViewDelegate: FilterCollectionViewDelegate?
    var tableViewDelegate: PostsTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterDelegate = FilterCollectionViewDelegate()
        self.collectionViewDelegate = filterDelegate
        collectionViewDelegate?.categories = ["Matemática", "História", "Geografia", "Biologia"]

        filterCollectionView.delegate = self.collectionViewDelegate
        filterCollectionView.dataSource = self.collectionViewDelegate
        
        let postsDelegate = PostsTableDelegate()
        self.tableViewDelegate = postsDelegate
        tableViewDelegate?.playlists = [List(userName: "Jaque",
                                                       userLevel: "Nível 7",
                                                       title: "Álgebra",
                                                       description: "Descrição dessa playlist",
                                                       category: "",
                                                       numberOfForks: 36,
                                                       type: "Playlist")]
        tableViewDelegate?.viewController = self
        playlistsTableView.delegate = tableViewDelegate
        playlistsTableView.dataSource = tableViewDelegate
    }

    @IBAction func forkPlaylist(_ sender: UIButton) {
        // verificar se usuário já salvou essa playlist
        tableViewDelegate?.playlists?[sender.tag].numberOfForks += 1
        playlistsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let destination = segue.destination as? PlaylistHomeController,
            let selectedPlaylist = tableViewDelegate?.selectedPlaylist {
                destination.playlist = selectedPlaylist
        }
    }
}
