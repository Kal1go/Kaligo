//
//  CreatePlaylistViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CreatePlaylistViewController: UIViewController {
    
    @IBOutlet weak var stepsTableView: UITableView!
    
    var stepsTableViewDelegate: StepsTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepsTableViewDelegate = StepsTableViewDelegate()
        stepsTableView.delegate = stepsTableViewDelegate
        stepsTableView.dataSource = stepsTableViewDelegate
        // Do any additional setup after loading the view.
    }
}
