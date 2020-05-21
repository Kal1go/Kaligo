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
    
    var nameDelegate: TextFieldDelegate?
    var descriptionDelegate: TextViewDelegate?
    var inputController: InputController?
    var pickerController: PickerController?
    
    var playlist = ModeloPlaylist()
        
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    private func getCategories() -> [String] {
        var categories = [String]()
        for value in Category.allCases {
            if value != .none {
                categories.append(value.rawValue)
            }
        }
        return categories
    }
}
