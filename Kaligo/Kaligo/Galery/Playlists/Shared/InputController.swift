//
//  InputController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 20/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

class InputController: InputDelegate {
    
    weak var tableViewDataSource: StepsTableViewDelegate?
    weak var tableViewController: PlaylistSaveController?
    
    init(dataSource: StepsTableViewDelegate?) {
        tableViewDataSource = dataSource
    }
    
    init(controller: PlaylistSaveController?) {
        tableViewController = controller
    }
    
    func setText(for index: Int, with text: String, type: InputType) {
        if let _ = tableViewDataSource {
            setStep(for: index, with: text, type)
            
        } else if let _ = tableViewController {
            setPlaylist(with: text, type)
        }
    }
    
    private func setStep(for index: Int, with text: String, _ type: InputType) {
        guard let steps = tableViewDataSource?.steps else { return }
        switch type {
        case .title:
            steps[index].title = text
        case .description:
            steps[index].description = text
        case .url:
            steps[index].url = text
        }
    }
    
    private func setPlaylist(with text: String, _ type: InputType) {
        guard let playlist = tableViewController?.playlist else { return }
        switch type {
        case .title:
            playlist.title = text
        case .description:
            playlist.description = text
        default:
            break
        }
    }
}
