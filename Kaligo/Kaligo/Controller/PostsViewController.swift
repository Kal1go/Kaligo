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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionDelegate = FilterCollectionViewDelegate()
        self.collectionViewDelegate = collectionDelegate
        collectionViewDelegate?.categories = ["Matemática", "História", "Geografia", "Biologia"]
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
