//
//  PlaylistHomeTableView.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class PlaylistHomeTableView: UITableViewController {
    private var data = Reviews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        setUpReviews()
    }
    
    func setUpReviews() {
        self.data.createReviewsWith(quantity: 6)
        self.tableView.estimatedRowHeight = 233
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ///Cell is defined in Main.storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        if cell.contentView.subviews.contains(where: { $0.tag == 999 }) == false {
            guard let customView = Bundle.main.loadNibNamed(String(describing: AwesomeReviewView.self),
                                                            owner: self, options: nil)?.first as? AwesomeReviewView else {
                fatalError("Is impossible take the View")
            }
            
            customView.tag = 999
            cell.contentView.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            customView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
            customView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            customView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            /**
             This **did tap handler** coming from the *AwesomeReviewView* which will let table view knows that there’s an action to be done. In this case, the table view will need to resize.
             */
            customView.onSeeMoreDidTap {
                [weak self] in
                self?.data[indexPath.row].isExpanded.toggle()
                /**
                 Once AwesomeReviewView has resized itself, it will be called **onSeeMoreDidTap**. This is the time for table view to resize that particular cell, **beginUpdates** and **endUpdates** will do the trick.
                 */
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            customView.setupWith(review: data[indexPath.row])
        }
        return cell
    }
}
