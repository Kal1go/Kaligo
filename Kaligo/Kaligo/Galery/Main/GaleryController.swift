//
//  GaleriaViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

var isMVP = false

class GaleryController: UIViewController {

    @IBOutlet weak var playlistsOptionImage: UIImageView!
    @IBOutlet weak var tipsOptionImage: UIImageView!
    @IBOutlet weak var playlistsTableView: UITableView!
    
    var tableViewDelegate: GaleryTableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewDelegate = GaleryTableView()
        generateData()
        tableViewDelegate?.delegate = self
        playlistsTableView.delegate = tableViewDelegate
        playlistsTableView.dataSource = tableViewDelegate
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editGalery(_:)))
        
//        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "Sair")?.withRenderingMode(.alwaysOriginal)
        
        //because the tableview size, we ned make this to configure the title large,
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }

    }
    
    override func awakeFromNib() {
        self.navigationController?.tabBarItem.image = UIImage(systemName: "rectangle.stack.fill")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if tableViewDelegate?.playlists?.count != CommonData.shared.user.list?.count {
            
            tableViewDelegate?.playlists = CommonData.shared.user.list
            playlistsTableView.reloadData()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          self.playlistsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    func generateData() {
        tableViewDelegate?.playlists = CommonData.shared.user.list
        tableViewDelegate?.tips = []
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
    
    @IBAction func forkPlaylist(_ sender: UIButton) {
        // verificar se usuário já salvou essa playlist
        tableViewDelegate?.playlists?[sender.tag].numberOfForks += 1
        
        let forkDefaultImage = UIImage(named: "botao-fork")
        let forkSelectedImage = UIImage(named: "botao-fork-selecionado")
        
        sender.isSelected.toggle()
        sender.setImage(sender.isSelected ? forkSelectedImage : forkDefaultImage, for: .normal)
    }
    
    @IBAction func logout() {
        self.showCustomAlert(title: "Sair",
                             message: "Deseja realmente encerrar sua sessão no aplicativo?",
                             isOneButton: false) { (answer) in
                                if answer {
                                    LoginController.logout(presenter: self)
                                }
        }
        
    }
    
    @objc func editGalery(_ sender: Any) {
        if playlistsTableView.isEditing {
            playlistsTableView.isEditing = false
            self.navigationItem.leftBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editGalery(_:)))
        } else {
            playlistsTableView.isEditing = true
            self.navigationItem.leftBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editGalery(_:)))
        }
    }
    
}

extension GaleryController: GaleryTableViewProtocol, PlaylistHomeControllerDelegate {
    func reloadData() {
        self.tableViewDelegate?.playlists = CommonData.shared.user.list
        self.playlistsTableView.reloadData()
    }
    func controller() -> UIViewController {
        return self
    }
    
    func segue(atIndex index: Int) {
        guard let list = tableViewDelegate?.playlists?[index] else { return }
        performSegue(withIdentifier: "listDetail", sender: list)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let navegation = segue.destination as? UINavigationController,
            let view = navegation.viewControllers.first as? PlaylistHomeController,
            let list = sender as? List {
                view.playlist = list
                view.delegate = self
        } else if
            let navegation = segue.destination as? UINavigationController,
            let view = navegation.viewControllers.first as? PlaylistCreateController {
            view.delegate = self
        }
    }
}
