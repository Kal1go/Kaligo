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
    public var playlists = Lists()
    
    private var indexOfPageToRequest = 0
    private var isLoading = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .clear
        self.loadMoreData()
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
            if playlists.count > indexPath.row {
                let playlist = playlists[indexPath.row]
                cell.configureCell(playlist: playlist,
                                   indexPath: indexPath)
            }
            
            
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    internal func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            self.getLast(){}
        }
    }
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height {
                self.loadMoreData()
        }
    }
    
    public func resetTable() {
        DispatchQueue.main.async {
            self.indexOfPageToRequest = 0
            self.playlists = []
            self.getLast {
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }
    }
    
    private func getLast(withCompletion complition: @escaping () -> Void) {
        DispatchQueue.main.async {
            let cell = self.cellForRow(at: .init(row: 0, section: 1))
            cell?.contentView.showSpinner()
            ListHandler.getLast(withNumber: self.indexOfPageToRequest) { (answer) in
                DispatchQueue.main.async {
                    switch answer {
                    case .success(let answer):
                        self.incrementPosts(lists: answer)
                        cell?.contentView.removeSpinner()
                    case .error(let description):
                        cell?.contentView.removeSpinner()
                        print(description)
                        self.viewController?
                            .showCustomAlert(title: "Ops, aparentemente tivemos algum problema",
                                             message: "Deseja realizar a busca novamente?",
                                             isOneButton: false) { (answer) in
                                                if answer {
                                                    self.getLast(){}
                                                }
                        }
                    }
                }
                
            }
        }
    }
    
    private func incrementPosts(lists: Lists) {
        guard lists.count > 0 else { return }
        DispatchQueue.main.async {
            self.indexOfPageToRequest += 1
            self.playlists.append(contentsOf: lists)
            self.reloadData()
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
