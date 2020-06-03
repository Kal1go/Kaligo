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
    @IBOutlet weak var postsTableView: PostsTableView!
    
    private var collectionViewDelegate: FilterCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterDelegate = FilterCollectionViewDelegate()
        self.collectionViewDelegate = filterDelegate
        collectionViewDelegate?.categories = ["Matemática", "História", "Geografia", "Biologia"]
        
        filterCollectionView.delegate = self.collectionViewDelegate
        filterCollectionView.dataSource = self.collectionViewDelegate

//        self.getLast()

        postsTableView?.viewController = self
    }
        
    @IBAction func forkPlaylist(_ sender: UIButton) {
        // verificar se usuário já salvou essa playlist
//        postsTableView?.playlists[sender.tag].numberOfForks += 1
//        
//        let forkDefaultImage = UIImage(named: "botao-fork")
//        let forkSelectedImage = UIImage(named: "botao-fork-selecionado")
//        
//        sender.isSelected.toggle()
//        sender.setImage(sender.isSelected ? forkSelectedImage : forkDefaultImage, for: .normal)
    }
    
    func performSegue(for playlist: List) {
        performSegue(withIdentifier: "listDetail", sender: playlist)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navegation = segue.destination as? UINavigationController,
            let view = navegation.viewControllers.first as? PlaylistHomeController,
            let selected = postsTableView.indexPathForSelectedRow,
            let delegate = postsTableView.delegate as? PostsTableView {
            view.playlist = delegate.playlists[selected.row]
        }
    }
}
