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

class GaleryPlaylistsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var playlists: [ModeloPlaylist]?
    var tips: [ModeloDica]?
    var filter: GaleryFilter = .playlists
    
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
                for: indexPath) as? AddPlaylistTableViewCell
                else { return UITableViewCell() }
            
            if filter == .playlists {
                cell.addButton.setTitle("Criar playlist", for: .normal)
                
            } else {
                cell.addButton.setTitle("Criar dica", for: .normal)
            }
            
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
            return cell
        }
    }
    
    private func setRow<T>(for cell: PlaylistTableViewCell, with data: T) {
        if let d = data as? ModeloPlaylist {
            cell.userName.text = d.userName
            cell.userLevel.text = d.userLevel
            cell.playlistTitle.text = d.title
            cell.playlistDescription.text = d.description
            cell.playlistCategory.text = d.category
            cell.numberOfForks.text = "\(d.numberOfForks)"
            
        } else if let d = data as? ModeloDica {
            cell.userName.text = d.userName
            cell.userLevel.text = d.userLevel
            cell.playlistTitle.text = d.title
            cell.playlistDescription.text = d.description
            cell.playlistCategory.text = d.category
        }
        
    }
    
}
