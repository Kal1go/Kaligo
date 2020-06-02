//
//  PlaylistTableViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PostsTableView: UITableView, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    weak var viewController: PostsViewController?
    var playlists = Lists()
    var selectedPlaylist: List?
    
    private var indexOfPageToRequest = 0
    private var isLoading = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundView?.showSpinner()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .clear
        self.getLast()
        self.backgroundView?.removeSpinner()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //Return the amount of items
            return  playlists.count
        } else {
            //Return the Loading cell
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "playlistCell",
                    for: indexPath) as? PlaylistTableViewCell
                else { return UITableViewCell() }
            
            let playlist = playlists[indexPath.row]
            
            cell.userName.text = playlist.userName != " " ? playlist.userName : "Sem nome"
            cell.userLevel.text = "Nível \(playlist.userLevel)"
            cell.playlistTitle.text = playlist.title
            cell.playlistDescription.text = playlist.description
            cell.playlistCategory.text = playlist.category
            cell.forkButton.tag = indexPath.row
            
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let playlist = playlists[indexPath.row]
//        selectedPlaylist = playlist
//        
//        viewController?.performSegue(for: playlist)
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.main.async {
                if let cell = self.cellForRow(at: .init(row: 0, section: 1)) {
                    cell.contentView.showSpinner()
                }
                self.getLast()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            self.loadMoreData()
        }
    }
    
    private func getLast() {
        ListHandler.getLast(withNumber: indexOfPageToRequest) { (answer) in
            switch answer {
            case .success(let answer):
                self.incrementPosts(lists: answer)
            case .error(let description):
                print(description)
                self.viewController?
                    .showCustomAlert(title: "Ops, aparentemente tivemos algum problema",
                                     message: "Deseja realizar a busca novamente?",
                                     isOneButton: false) { (answer) in
                                        if answer {
                                            self.getLast()
                                        }
                }
            }
            
        }
    }
    
    private func incrementPosts(lists: Lists) {
        DispatchQueue.main.async {
            self.indexOfPageToRequest += 1
            self.playlists.append(contentsOf: lists)
            self.reloadData {
                if let cell = self.cellForRow(at: .init(row: 0, section: 1)) {
                    cell.contentView.removeSpinner()
                }
            }
            self.isLoading = false
        }
    }
}

extension UITableView {
    func reloadData(completion :@escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
}
