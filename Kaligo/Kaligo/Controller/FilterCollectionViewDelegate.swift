//
//  FilterCollectionViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 15/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class FilterCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var categories: [String]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "filterCell",
                for: indexPath) as? SegmentedCollectionViewCell,
            let categories = self.categories
            else { return UICollectionViewCell() }
        
        cell.filterTitle.text = categories[indexPath.row]
        
        return cell
    }

}
