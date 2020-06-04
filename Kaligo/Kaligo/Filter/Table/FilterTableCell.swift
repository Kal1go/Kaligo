//
//  FilterTableCell.swift
//  Kaligo
//
//  Created by Matheus Silva on 04/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class FilterTableCell: UITableViewCell {
    
    @IBOutlet weak var collection: UICollectionView!
    var collectionDataSourceDelegate: FilterDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionDataSourceDelegate = FilterDataSource(collectionView: collection)
        collectionDataSourceDelegate?.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension FilterTableCell: FilterDataSourceDelegate {
    func filterBy(category: [String]) {
        print(category)
    }
}
