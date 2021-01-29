//
//  HomeViewController.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

//terminar o homeViewController
class HomeViewController: UIViewController {

    @IBOutlet weak var imagePerfilHome: UIImageView!
    @IBOutlet weak var labelNivelHome: UILabel!
    @IBOutlet weak var labelOlaHome: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var dicasTableViewHome: UITableView!
    weak var collectionViewDelegate: HomeCollectionViewDelegate?
    
    override func viewDidLoad() {
        let collectionDelegate = HomeCollectionViewDelegate()
        self.collectionViewDelegate = collectionDelegate
        collectionViewDelegate?.dicasCards = ["dica1", "dica2", "dica3"]
    }
}
