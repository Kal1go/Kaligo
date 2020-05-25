//
//  HomeCollectionViewDelegate.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class HomeCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dicasCards: [String]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dicasCards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "dicasCardsCell",
                for: indexPath) as? SegmentedHomeCollectionViewCell,
            let dicasCards = self.dicasCards
            else { return UICollectionViewCell() }
        
        cell.tituloCardCollectionHome.text = dicasCards[indexPath.row]
        
        return cell
    }
}
