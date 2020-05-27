//
//  GaleriaViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

var isMVP = true

class GaleryController: UIViewController {

    @IBOutlet weak var playlistsOptionImage: UIImageView!
    @IBOutlet weak var tipsOptionImage: UIImageView!
    @IBOutlet weak var playlistsTableView: UITableView!
    @IBOutlet weak var noPlaylistLabel: UILabel!
    
    var tableViewDelegate: GaleryTableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewDelegate = GaleryTableView()
        generateData()
        setNoPlaylistLabel()
        tableViewDelegate?.delegate = self
        playlistsTableView.delegate = tableViewDelegate
        playlistsTableView.dataSource = tableViewDelegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)    
        setNoPlaylistLabel()
    }

    func generateData() {
        tableViewDelegate?.playlists = CommonData.shared.user.list
        tableViewDelegate?.tips = []
    }
    
    func setNoPlaylistLabel() {
        guard let playlists = tableViewDelegate?.playlists else { return }
        
        noPlaylistLabel.isHidden = playlists.isEmpty ? false : true
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        if sender.tag == 1 {
            playlistsOptionImage.tintColor = UIColor(named: "Clicavel")
            tipsOptionImage.tintColor = UIColor(named: "Background")
            tableViewDelegate?.filter = .playlists
        } else {
            tipsOptionImage.tintColor = UIColor(named: "Clicavel")
            playlistsOptionImage.tintColor = UIColor(named: "Background")
            tableViewDelegate?.filter = .tips
        }
        playlistsTableView.reloadData()
    }
    
    @IBAction func savePlaylist(_ sender: UIStoryboardSegue) {
        if let source = sender.source as? PlaylistSaveController {
            tableViewDelegate?.playlists?.append(source.playlist)
            playlistsTableView.reloadData()
        }
    }
    
    @IBAction func logout() {
        LoginController.logout(presenter: self)
    }
}

extension GaleryController: GaleryTableViewProtocol {
    func reloadData() {
        self.tableViewDelegate?.playlists = CommonData.shared.user.list
        self.playlistsTableView.reloadData()
    }
    func controller() -> UIViewController {
        return self
    }
    
    func segue(atIndex index: Int) {
        guard let list = tableViewDelegate?.playlists?[index] else {
            fatalError("Where stay the list???")
        }
        performSegue(withIdentifier: "listDetail", sender: list)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let navegation = segue.destination as? UINavigationController,
            let view = navegation.viewControllers.first as? PlaylistHomeController,
            let list = sender as? List {
                view.playlist = list
                view.delegate = self
        }
    }
}
