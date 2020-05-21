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
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    var stepsTableViewDelegate: StepsTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false

        stepsTableViewDelegate = StepsTableViewDelegate()
        stepsTableView.delegate = stepsTableViewDelegate
        stepsTableView.dataSource = stepsTableViewDelegate
        stepsTableView.tableFooterView = UIView()
        
        guard let delegate = stepsTableViewDelegate else { return }
        delegate.inputController = InputController(dataSource: delegate)
        
        guard let inputController = delegate.inputController else { return }
        delegate.titleDelegate = TextFieldDelegate(delegate: inputController, type: .title)
        delegate.descriptionDelegate = TextViewDelegate(delegate: inputController, type: .description)
        delegate.urlDelegate = TextFieldDelegate(delegate: inputController, type: .url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let savePlaylist = segue.destination as? SavePlaylistTableViewController,
            let steps = stepsTableViewDelegate?.steps {
            savePlaylist.playlist.steps = steps
        }
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
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if
            let delegate = stepsTableViewDelegate,
            let textFieldDelegate = delegate.titleDelegate,
            sender.tag == 0 {
            nextButton.isEnabled = textFieldDelegate.validateText(for: sender)
        }
    }
}
