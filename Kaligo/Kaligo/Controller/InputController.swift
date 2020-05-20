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
    
    init(dataSource: StepsTableViewDelegate?) {
        tableViewDataSource = dataSource
    }
    
    func setText(for index: Int, with text: String, type: InputType) {
        guard let steps = tableViewDataSource?.steps else { return }
        switch type {
        case .title:
            steps[index].title = text
        case .url:
            steps[index].title = text
        default:
            break
        }
    }
}
