//
//  PlaylistHomeTableView.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class PlaylistHomeController: UITableViewController {

    var playlist = List()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        navigationItem.title = playlist.title
        self.tableView.estimatedRowHeight = 233
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && !isMVP {
            return 100
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isMVP {
            return (playlist.steps?.count ?? 0)
        }
        return (playlist.steps?.count ?? 0) + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && !isMVP {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            
            if let cell1 = cell1 as? StepsMainViewCell {
                cell1.userNameLabel.text = playlist.userName
                cell1.userLevelLabel.text = playlist.userLevel
                cell1.numberOfForksLabel.text = String(playlist.numberOfForks)
                return cell1
            }
            return cell1
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        if cell.contentView.subviews.contains(where: { $0.tag == 999 }) == false {
            guard let customView = Bundle.main.loadNibNamed(
                String(describing: StepViewCell.self),
                       owner: self,
                       options: nil)?.first as? StepViewCell
                else {
                 fatalError("Is impossible take the View")
            }
            
            var row: Int
            if isMVP {
                row = indexPath.row
            } else {
                row = indexPath.row - 1
            }
            
            guard let step = playlist.steps?[row] else {
                fatalError("Is impossible take Step")
            }
            
            customView.tag = 999
            cell.contentView.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            customView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
            customView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            customView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            
            customView.numeroDePassos.text = String(0)
            
            customView.onSeeMoreDidTap {
                [weak self] in
                self?.playlist.steps?[indexPath.row - 1].isExpanded?.toggle()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            customView.setupWith(step: step)
        }
        return cell
    }
}
