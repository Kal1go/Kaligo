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
            
            return cell
            
        } else {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "playlistCell",
                    for: indexPath) as? PlaylistTableViewCell,
                let playlists = self.playlists
                else { return UITableViewCell() }
            
            let playlist = playlists[indexPath.row]
            setPlaylistRow(for: cell, with: playlist)
            
            return cell
        }
        
    }
    
    func setPlaylistRow(for cell: PlaylistTableViewCell, with playlist: ModeloPlaylist) {
        cell.userName.text = playlist.userName
        cell.userLevel.text = playlist.userLevel
        cell.playlistTitle.text = playlist.title
        cell.playlistDescription.text = playlist.description
        cell.playlistCategory.text = playlist.category
        cell.numberOfForks.text = "\(playlist.numberOfForks)"
    }
    
}
