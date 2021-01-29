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
    public var collectionDataSourceDelegate: FilterDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionDataSourceDelegate = FilterDataSource(collectionView: collection)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


