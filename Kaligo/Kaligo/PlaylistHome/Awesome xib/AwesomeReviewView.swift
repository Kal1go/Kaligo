//
//  AwesomeReviewView.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class AwesomeReviewView: UIView {
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet weak var numeroDePassos: UILabel!
    @IBOutlet weak var imageNumeroDePassos: UIImageView!
    
    private var isSeeLess: Bool = true
    private var seeMoreDidTapHandler: (() -> Void)?
    
    @IBAction func seeMoreButtonTapped() {
        self.isSeeLess.toggle()
        self.descLabel.numberOfLines = self.isSeeLess ? 0 : 7
        self.descLabel.layoutIfNeeded()
        self.seeMoreButton.setTitle(self.isSeeLess ? "See less" : "See more", for: .normal)
        self.seeMoreDidTapHandler?()
    }
    
    func onSeeMoreDidTap(_ handler: @escaping () -> Void) {
        self.seeMoreDidTapHandler = handler
    }
    
    func setupWith(review: Review) {
        self.numeroDePassos.text = review.numeroDePassos
        numeroDePassos.text = review.numeroDePassos
        
        self.userNameLabel.text = review.title
        self.descLabel.text = review.description + review.description + review.description + review.description + review.description
        self.dateLabel.text = review.date
        self.isSeeLess = review.isExpanded
        self.descLabel.numberOfLines = self.isSeeLess ? 0 : 7
        self.seeMoreButton.setTitle(self.isSeeLess ? "See less" : "See more", for: .normal)
    }
    
}
