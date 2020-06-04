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
            guard let count = playlists?.count else { return 1 }
            return count == 0 ? 2 : 1
            
        } else {
            return playlists?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return indexPath.row == 0 ? 81 : 350
        }
        return 229
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "addPlaylistCell",
                    for: indexPath) as? GaleryTableCell
                    else { return UITableViewCell() }
                
//                cell.selectionStyle = .default
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "noPlaylistCell") else { return UITableViewCell() }
            return cell
            
        } else {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "playlistCell",
                    for: indexPath) as? PlaylistTableViewCell,
                let playlists = playlists
                else { return UITableViewCell() }
            
            let playlist = playlists[indexPath.row]
            cell.configureCell(playlist: playlist, indexPath: indexPath)
            cell.selectionStyle = .none
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
                                        EventManager.shared.trigger(eventName: "reloadPosts")
                                        controller.view.removeSpinner()
                                        self.delegate?.reloadData()
                                        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            DispatchQueue.main.async {
                self.delegate?.segue(atIndex: indexPath.row)
            }
        }
    }
    
}
