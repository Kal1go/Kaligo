//
//  SavePlaylistTableViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class SavePlaylistTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var nameDelegate: TextFieldDelegate?
    var descriptionDelegate: TextViewDelegate?
    var inputController: InputController?
    var pickerController: PickerController?
    
    var playlist = ModeloPlaylist()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false

        inputController = InputController(controller: self)
        
        guard let inputController = inputController else { return }
        nameDelegate = TextFieldDelegate(delegate: inputController, type: .title)
        descriptionDelegate = TextViewDelegate(delegate: inputController, type: .description)
        
        nameTextField.delegate = nameDelegate
        descriptionTextView.delegate = descriptionDelegate
        descriptionDelegate?.setTextView(descriptionTextView)
        
        pickerController = PickerController(components: getCategories())
        categoryPickerView.delegate = pickerController
        categoryPickerView.dataSource = pickerController
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard
            let selectedValue = pickerController?.selected,
            let category = Category(rawValue: selectedValue)
            else { return }
        
        playlist.category = category
        
        validateSteps()
    }
    
    private func getCategories() -> [String] {
        var categories = [String]()
        for value in Category.allCases {
            if value != .none {
                categories.append(value.rawValue)
            }
        }
        return categories
    }
    
    private func validateSteps() {
        var invalidIndexes = [Int]()
        
        for i in 0 ..< playlist.steps.count {
            if playlist.steps[i].title == "" && playlist.steps[i].description == "" && playlist.steps[i].url == ""{
                invalidIndexes.append(i)
            }
        }
        
        invalidIndexes = invalidIndexes.sorted(by: >)
        
        for i in invalidIndexes {
            playlist.steps.remove(at: i)
        }
        
        for i in 0 ..< playlist.steps.count {
            playlist.steps[i].number = i + 1
        }
        
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        guard let delegate = nameDelegate else { return }
        
        saveButton.isEnabled = delegate.validateText(for: sender)
    }
}
