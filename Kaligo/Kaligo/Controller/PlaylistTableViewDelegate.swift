//
//  PlaylistTableViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PlaylistTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var playlists: [ModeloPlaylist]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "playlistCell",
                for: indexPath) as? PlaylistTableViewCell,
            let playlists = self.playlists
            else { return UITableViewCell() }
        
        let playlist = playlists[indexPath.row]
        
        cell.userName.text = playlist.userName
        cell.userLevel.text = playlist.userLevel
        cell.playlistTitle.text = playlist.title
        cell.playlistDescription.text = playlist.description
        cell.playlistCategory.text = playlist.category
        cell.numberOfForks.text = "\(playlist.numberOfForks)"
        
        return cell
    }
    
    
}
