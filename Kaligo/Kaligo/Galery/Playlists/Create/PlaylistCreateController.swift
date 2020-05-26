//
//  CreatePlaylistViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PlaylistCreateController: UIViewController {
    
    @IBOutlet weak var stepsTableView: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    //TODO: - Transformar em weak
    var stepsTableViewDelegate: StepsTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDismissKeyboard()
        nextButton.isEnabled = false
        
        if stepsTableViewDelegate == nil {
            stepsTableViewDelegate = StepsTableViewDelegate()
        } else {
            nextButton.isEnabled = true
        }
        
        stepsTableView.delegate = stepsTableViewDelegate
        stepsTableView.dataSource = stepsTableViewDelegate
        
        stepsTableView.tableFooterView = UIView()
        
        //because the tableview size, we ned make this to configure the title large, 
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
        
        guard let delegate = stepsTableViewDelegate else { return }
        delegate.inputController = InputController(dataSource: delegate)
        
        guard let inputController = delegate.inputController else { return }
        delegate.titleDelegate = TextFieldDelegate(delegate: inputController, type: .title)
        delegate.descriptionDelegate = TextViewDelegate(delegate: inputController, type: .description)
        delegate.urlDelegate = TextFieldDelegate(delegate: inputController, type: .url)
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          self.stepsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 340, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let view = segue.destination as? PlaylistSaveController,
            let steps = stepsTableViewDelegate?.steps {
            view.playlist.steps = steps
            if let list = stepsTableViewDelegate?.list {
                view.playlist = list
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let steps = stepsTableViewDelegate?.steps else { return false }
        
        if steps.count > 1 {
            for step in steps {
                if step.title == "" {
                    showCustomAlert(title: "Passo incompleto!",
                                    message: "Todos os passos da sua playlist devem ter um título",
                                    isOneButton: true) { _ in }
                    
                    return false
                }
            }
        }
        
        return true
    }
    
    @IBAction func addStep(_ sender: Any) {
        if let numberOfSteps = stepsTableViewDelegate?.steps.count {
            stepsTableViewDelegate?.steps.append(Step(number: numberOfSteps + 1))
            stepsTableView.reloadData()
        }
    }
    
    @IBAction func deleteStep(_ sender: UIButton) {
        view.endEditing(true)
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
