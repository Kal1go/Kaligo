//
//  PlaylistHomeTableView.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

protocol PlaylistHomeControllerDelegate: class {
    func reloadData()
}
class PlaylistHomeController: UITableViewController {

    var playlist = List()
    weak var delegate: GaleryTableViewProtocol?
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        // In this case, the user not is owner
        editButton.isEnabled = playlist.isOwner()
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
                cell1.setUp(list: playlist)
                cell1.delegate = self
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
            row = isMVP ? indexPath.row : indexPath.row - 1
            
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
        } else if let cell = cell.contentView.subviews.first(where: { $0.tag == 999 }) as? StepViewCell {
            guard let step = playlist.steps?[indexPath.row - 1] else {
                fatalError("Is impossible take Step")
            }
            cell.setupWith(step: step)
        }
        return cell
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if
                let navegation = segue.destination as? UINavigationController,
                let view = navegation.viewControllers.first as? PlaylistCreateController {
               view.isUpdate = true
               view.list = playlist
               view.delegate = self
           }
           
           if
               let navegation = segue.destination as? UINavigationController,
               let view = navegation.viewControllers.first as? PlaylistHomeController,
               let list = sender as? List {
                   view.playlist = list
           }
       }
}

extension PlaylistHomeController: PlaylistHomeControllerDelegate {
    func reloadData() {
        if let list = User.find(withId: playlist._id) {
            playlist = list
            setUp()
            tableView.reloadData()
            delegate?.reloadData()
        }
    }
}

extension PlaylistHomeController: StepsMainViewCellDelegate {
    func fork() {
        guard
            let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? StepsMainViewCell
        else {
            return
        }
        cell.showSpinner()
        ListHandler.fork(params: playlist) { (answer) in
            switch answer {
            case.success(let answer):
                DispatchQueue.main.async {
                    cell.removeSpinner()
                    self.playlist = answer
                    let forkSelectedImage = UIImage(named: "botao-fork-selecionado")
                    cell.forkButton.setImage(forkSelectedImage, for: .normal)
                    cell.forkButton.isEnabled = false
                    User.addlist(list: answer)
                    self.setUp()
                    self.tableView.reloadData()
                    EventManager.shared.trigger(eventName: "reloadPosts")
                }
            case.error(let description):
                self.showCustomAlert(title: "Ops, algo deu errado!", message: description, isOneButton: true) { (_) in }
            }
        }
    }
}
