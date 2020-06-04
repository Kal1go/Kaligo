//
//  FilterCollectionViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 15/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//
import Foundation
import UIKit

protocol FilterDataSourceDelegate: class {
    func filterBy(category: [String])
}

class FilterDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public weak var delegate: FilterDataSourceDelegate?
    public var categories: [String] {
        var answer = [all]
        answer.append(contentsOf: Categories.getCategories())
        return answer
    }
    private var collectionView: UICollectionView
    
    private var filters: [String] = [String]()
    private let all = " Todas "
    private var allButtons = [UIButton]()
    private var allButton = UIButton()
    
    private let primaryColor: UIColor = .tintMedium
    private let primaryTextColor: UIColor = .backgroundMedium
    
    private let secondColor: UIColor = .backgroundMedium
    private let secondTextColor: UIColor = .tintMedium
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.initAllButtons()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.register()
        self.setUpCollection()
    }

    private func register() {
        let filterCell = UINib(nibName: "FilterCell", bundle: nil)
        collectionView.register(filterCell, forCellWithReuseIdentifier: "FilterCell")
    }
    
    private func initAllButtons() {
        categories.forEach { elem in
            self.allButtons.append(UIButton())
        }
    }
    
    private func setUpCollection() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell
            else { return UICollectionViewCell() }
    
        cell.filterButton.setTitle(categories[indexPath.row], for: .normal)
        
        cell.filterButton.addTarget(self, action: #selector(filter), for: .touchUpInside)
        cell.filterButton.tag = indexPath.row
        
        let name = categories[indexPath.row]
            if name == all {
                if filters.count == 0 {
                    allButton = cell.filterButton
                    allButton.backgroundColor = primaryColor
                    allButton.setTitleColor(secondColor, for: .normal)
                }
            } else {
                if filters.contains(name) {
                    cell.filterButton.backgroundColor =  primaryColor
                    cell.filterButton.setTitleColor(secondColor, for: .normal)
                } else {
                    cell.filterButton.backgroundColor = secondColor
                    cell.filterButton.setTitleColor(primaryColor, for: .normal)
                }
            
        }
        allButtons[indexPath.row] = cell.filterButton
        return cell
    }

    @objc
    func filter(_ sender: UIButton) {
        guard let tag = sender.titleLabel?.text else {
            NSLog("Error: Impossivel let Tag do Toggle")
            return
        }
        if tag == all {
            for button in allButtons {
                if let textButton = button.titleLabel?.text {
                    if filters.contains(textButton) {
                        button.backgroundColor = secondColor
                        button.setTitleColor(primaryColor, for: .normal)
                    }
                }
            }
            allButton.backgroundColor = primaryColor
            allButton.setTitleColor(secondColor, for: .normal)
            
            filters.removeAll()
        } else if !filters.contains(tag) || filters.count != 0 {
            allButton.backgroundColor = secondColor
            allButton.setTitleColor(primaryColor, for: .normal)
            
            if !filters.contains(tag) { //Ativar
                allButtons[sender.tag].backgroundColor = primaryColor
                allButtons[sender.tag].setTitleColor(secondColor, for: .normal)
                filters.append(tag)
            } else {
                allButtons[sender.tag].backgroundColor = secondColor
                allButtons[sender.tag].setTitleColor(primaryColor, for: .normal)
                if let index = filters.firstIndex(of: tag) {
                    filters.remove(at: index)
                }
            }
        }
        
        if filters.count == 0, let index = allButtons.firstIndex(of: allButton) {
            if let name = allButtons[index].titleLabel?.text, name == all {
                allButtons[index].backgroundColor = primaryColor
                allButtons[index].setTitleColor(secondColor, for: .normal)
            }
        }
        
        delegate?.filterBy(category: filters)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        let size = categories[indexPath.row].count
        
        var variable: CGFloat = .zero
        switch size {
        case 0...5:
            variable = 14
        case 5...15:
            variable = 12
        default:
            variable = 10
        }
        let width: CGFloat = CGFloat(size) * variable
        return CGSize(width: width, height: height)
    }
}
