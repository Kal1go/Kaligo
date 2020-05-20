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
        stepsTableView.tableFooterView = UIView()
        
        guard let delegate = stepsTableViewDelegate else { return }
        delegate.inputController = InputController(dataSource: delegate)
        
        guard let inputController = delegate.inputController else { return }
        delegate.titleDelegate = TextFieldDelegate(delegate: inputController, type: .title)
        delegate.urlDelegate = TextFieldDelegate(delegate: inputController, type: .url)
    }
    
    @IBAction func addStep(_ sender: Any) {
        if let numberOfSteps = stepsTableViewDelegate?.steps.count {
            stepsTableViewDelegate?.steps.append(ModeloPasso(number: numberOfSteps + 1))
            stepsTableView.reloadData()
        }
    }
    
    @IBAction func deleteStep(_ sender: UIButton) {
        stepsTableViewDelegate?.deleteStep(at: sender.tag)
        stepsTableView.reloadData()
    }
    
    @IBAction func showSteps(_ sender: Any) {
        print(stepsTableViewDelegate?.steps as Any)
    }
    
    
}
