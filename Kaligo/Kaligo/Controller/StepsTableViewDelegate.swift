//
//  StepsTableViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class StepsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var steps = [ModeloPasso]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if steps.isEmpty {
            return 1
        }
        
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "stepCell",
                for: indexPath) as? StepTableViewCell
            else { return UITableViewCell() }
        
        if steps.isEmpty {
            cell.deleteButton.tag = 1
            cell.stepNumber.text = "1"
        } else {
            let step = steps[indexPath.row]
            cell.deleteButton.tag = step.number
            cell.stepNumber.text = "\(step.number)"
            cell.titleTextField.text = step.title
            cell.descriptionTextField.text = step.description
            cell.urlTextField.text = step.url
        }
        
        return cell
    }
    
}
