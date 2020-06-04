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
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpEvents()
        postsTableView?.viewController = self
    }
    
    private func setUpEvents() {
        EventManager.shared.listenTo(eventName: "reloadPosts") {
            self.postsTableView.resetTable()
        }
    }
        
    @IBAction func forkPlaylist(_ sender: UIButton) {
        guard
            let cell = postsTableView?.cellForRow(at: IndexPath(row: sender.tag, section: 1)) as? PlaylistTableViewCell,
            let list = postsTableView?.listsFilted[sender.tag]
        else {
            return
        }
        cell.showSpinner()
        ListHandler.fork(params: list) { (answer) in
            switch answer {
            case.success(let answer):
                DispatchQueue.main.async {
                    cell.removeSpinner()
                    let forkSelectedImage = UIImage(named: "botao-fork-selecionado")
                    sender.setImage(forkSelectedImage, for: .normal)
                    sender.isEnabled = false
                    self.postsTableView?.listsFilted[sender.tag].hasFork = true
                    self.postsTableView?.listsFilted[sender.tag].numberOfForks += 1
                    cell.configureCell(playlist: list, indexPath: IndexPath(row: sender.tag, section: 0))
                    User.addlist(list: answer)
                }
            case.error(let description):
                self.showCustomAlert(title: "Ops, algo deu errado!", message: description, isOneButton: true) { (_) in }
            }
        }
    }
    
    func messageLabel(isHidden: Bool) {
        self.messageLabel.isHidden = isHidden
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postsTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func performSegue(for playlist: List) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "listDetail", sender: playlist)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navegation = segue.destination as? UINavigationController,
            let list = sender as? List,
            let view = navegation.viewControllers.first as? PlaylistHomeController {
            view.playlist = list
        }
    }
}
