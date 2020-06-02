//
//  GaleryPlaylistsTableViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

enum GaleryFilter {
    case playlists
    case tips
}

protocol GaleryTableViewProtocol: NSObject {
    func segue(atIndex index: Int)
    func controller() -> UIViewController
    func reloadData()
}

class GaleryTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var playlists: Lists?
    var tips: [ModeloDica]?
    var filter: GaleryFilter = .playlists
    weak var delegate: GaleryTableViewProtocol?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return playlists?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "addPlaylistCell",
                for: indexPath) as? GaleryTableCell
                else { return UITableViewCell() }
            
            if filter == .playlists {
                cell.addButton.setTitle("Criar playlist", for: .normal)
                
            } else {
                cell.addButton.setTitle("Criar dica", for: .normal)
            }
            cell.selectionStyle = .none
            return cell
            
        } else {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "playlistCell",
                    for: indexPath) as? PlaylistTableViewCell,
                let playlists = playlists,
                let tips = tips
                else { return UITableViewCell() }
            
            if filter == .playlists {
                let playlist = playlists[indexPath.row]
                setRow(for: cell, with: playlist)
                
            } else {
                let tip = tips[indexPath.row]
                setRow(for: cell, with: tip)
            }
            cell.selectionStyle = .none
            cell.setUp()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section != 0 else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .destructive,
            title: "",
            handler: { (action, view, completionHandler) in
                guard let list = self.playlists?[indexPath.row],
                    let listID = list._id,
                    let controller = self.delegate?.controller() else {
                    completionHandler(false)
                    return
                }
                DispatchQueue.main.async {
                    controller.showCustomAlert(title: "Deletar Playlist",
                                               message: "Depois que deletado, você não poderá mais recuperar, tem certeza de que deseja deletar?",
                                               isOneButton: false) { answer in
                        if answer {
                            controller.view.showSpinner()
                            ListHandler.deleteOne(id: listID) { (response) in
                                DispatchQueue.main.async {
                                    switch response {
                                    case .success(let answer):
                                        self.playlists = List.delete(list: answer)
                                        controller.view.removeSpinner()
                                        self.delegate?.reloadData()
                                        if let galeryController = controller as? GaleryController {
                                            galeryController.setNoPlaylistLabel()
                                        }
                                    case .error(let description):
                                        controller.view.removeSpinner()
                                        controller.showCustomAlert(title: "Opss, algo deu errado", message: description, isOneButton: true) { _ in }
                                    }
                                }
                            }
                            
                        } else {
                            controller.view.removeSpinner()
                        }
                    }
                }
        })
        
        action.image = #imageLiteral(resourceName: "botao-excluirplaylist")
        action.backgroundColor = UIColor(named: "Background")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    private func setRow<T>(for cell: PlaylistTableViewCell, with data: T) {
        if let d = data as? List {
            cell.userName.text = d.userName
            cell.userLevel.text = d.userLevel
            cell.playlistTitle.text = d.title
            cell.playlistDescription.text = d.description
            cell.playlistCategory.text = d.category
        } else if let d = data as? ModeloDica {
            cell.userName.text = d.userName
            cell.userLevel.text = d.userLevel
            cell.playlistTitle.text = d.title
            cell.playlistDescription.text = d.description
            cell.playlistCategory.text = d.category
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            delegate?.segue(atIndex: indexPath.row)
        }
    }
    
}
