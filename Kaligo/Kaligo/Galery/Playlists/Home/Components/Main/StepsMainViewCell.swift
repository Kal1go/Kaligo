//
//  PlaylistHomeTableVewCell.swift
//  Kaligo
//
//  Created by Mariana Lima on 20/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

protocol StepsMainViewCellDelegate: class {
    func fork()
}
class StepsMainViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var forkButton: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    
    weak var delegate: StepsMainViewCellDelegate?
    private var imageForkS = UIImage(named: "botao-fork-selecionado")
    private var imageFork = UIImage(named: "botao-fork")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.forkButton.addTarget(self,
        action: #selector(clickFork),
        for: .touchUpInside)
    }
    
    func setUp(list: List) {
        self.userNameLabel.text = "\(list.userName)"
        print(list.category)
        self.categoryImage.image = UIImage(named: "\(list.category)")
        let isForked = list.isOwner() || list.hasForked()
        self.forkButton.setImage(isForked ? imageForkS : imageFork, for: .normal)
        self.forkButton.isEnabled = !isForked
    }
    
    @objc private
    func clickFork() {
        delegate?.fork()
    }
}
