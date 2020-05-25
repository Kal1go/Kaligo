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

    weak var collectionViewDelegate: FilterCollectionViewDelegate?
    weak var tableViewDelegate: PostsTableDelegate?

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
