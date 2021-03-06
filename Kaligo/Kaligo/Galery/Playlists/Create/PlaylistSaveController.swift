//
//  SavePlaylistTableViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PlaylistSaveController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var nameDelegate: TextFieldDelegate?
    var descriptionDelegate: TextViewDelegate?
    var inputController: InputController?
    var pickerController: PlaylistSavePicker?
    
    let sectionTitles = ["Informações", "Categoria"]
    
    weak var delegate: PlaylistHomeControllerDelegate?
    
    var playlist = List()
    private var isUpdate = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDismissKeyboard()
        saveButton.isEnabled = false
        inputController = InputController(controller: self)
        
        guard let inputController = inputController else { return }
        nameDelegate = TextFieldDelegate(delegate: inputController, type: .title)
        descriptionDelegate = TextViewDelegate(delegate: inputController, type: .description)
        
        nameTextField.delegate = nameDelegate
        descriptionTextView.delegate = descriptionDelegate
        descriptionDelegate?.setTextView(descriptionTextView)
        
        pickerController = PlaylistSavePicker(components: Categories.getCategories())
        categoryPickerView.delegate = pickerController
        categoryPickerView.dataSource = pickerController
        
        let headerNib = UINib.init(nibName: "SectionHeaderView", bundle: Bundle.main)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
        
        preLoadConfigure()
    }
    
    private func preLoadConfigure() {
        guard playlist.title != "" else { return }
        
        isUpdate = true
        saveButton.isEnabled = true
        nameTextField.text = playlist.title
        descriptionDelegate?.setTextView(descriptionTextView,
                                                                    with: playlist.description)
        pickerController?.selected = playlist.category
        for (index, value) in Category.allCases.enumerated() {
            if value.rawValue == playlist.category {
                categoryPickerView.selectRow(index,
                                             inComponent: 0,
                                             animated: true)
                return
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard
            let selectedValue = pickerController?.selected,
            let category = Category(rawValue: selectedValue)
            else { return }
        
        playlist.category = category.rawValue
        
        validateSteps()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as? SectionHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        headerView.titleLabel.text = sectionTitles[section]

        return headerView
    }
    
    private func validateSteps() {
        var invalidIndexes = [Int]()
        
        for i in 0 ..< (playlist.steps?.count ?? 0) {
            if playlist.steps?[i].title == "" && playlist.steps?[i].description == "" && playlist.steps?[i].url == "" {
                invalidIndexes.append(i)
            }
        }
        
        invalidIndexes = invalidIndexes.sorted(by: >)
        
        for i in invalidIndexes {
            playlist.steps?.remove(at: i)
        }
        
        for i in 0 ..< (playlist.steps?.count ?? 0) {
            playlist.steps?[i].number = i + 1
        }
        
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        guard let delegate = nameDelegate else { return }
        saveButton.isEnabled = delegate.validateText(for: sender)
    }
    
    private func preConfigure() {
        playlist.type = "Playlist"
        playlist.category = pickerController?.selected ?? ""
        playlist.userName = CommonData.shared.user.name
        playlist.userLevel = CommonData.shared.user.level
        playlist._id = CommonData.shared.user._id
    }
    
    @IBAction func save() {
        self.view.endEditing(true)
        self.view.showSpinner()
        if isUpdate {
            playlist.category = pickerController?.selected ?? ""
            updateList()
        } else {
            self.preConfigure()
            createList()
        }
    }
    
    private func createList() {
        ListHandler.create(list: playlist) { (response) in
            switch response {
            case .success(let answer):
                DispatchQueue.main.async {
                    User.addlist(list: answer)
                    self.delegate?.reloadData()
                    self.view.removeSpinner()
                    self.navigationController?.previousViewController?.back()
                }
            case .error(let description):
                print(description)
                DispatchQueue.main.async {
                    self.view.removeSpinner()
                    self.showCustomAlert(title: "Algo deu errado", message: "Verifique sua conexão com a internet.", isOneButton: true) { _ in }
                }
            }
            
        }
    }
    private func updateList() {
        ListHandler.update(params: playlist) { (response) in
            switch response {
            case .success(let answer):
                DispatchQueue.main.async {
                    User.updatelist(list: answer)
                    self.view.removeSpinner()
                    self.delegate?.reloadData()
                    self.navigationController?.previousViewController?.back()
                    EventManager.shared.trigger(eventName: "reloadPosts")
                }
            case .error(let description):
                print(description)
                DispatchQueue.main.async {
                    self.view.removeSpinner()
                    self.showCustomAlert(title: "Algo deu errado", message: "Verifique sua conexão com a internet.", isOneButton: true) { _ in }
                }
            }
        }
    }
}
