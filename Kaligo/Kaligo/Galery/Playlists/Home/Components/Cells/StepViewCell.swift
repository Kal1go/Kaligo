//
//  AwesomeReviewView.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class StepViewCell: UIView {
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet weak var numeroDePassos: UILabel!
    
    private var isSeeLess: Bool = true
    private var seeMoreDidTapHandler: (() -> Void)?
    
    @IBAction func seeMoreButtonTapped() {
        self.isSeeLess.toggle()
        self.descLabel.numberOfLines = self.isSeeLess ? 0 : 3
        self.descLabel.layoutIfNeeded()
        self.seeMoreButton.setTitle(self.isSeeLess ? "See less" : "See more", for: .normal)
        self.seeMoreDidTapHandler?()
    }
    
    func onSeeMoreDidTap(_ handler: @escaping () -> Void) {
        self.seeMoreDidTapHandler = handler
    }
    
    func setupWith(step: Step) {
        self.titleLabel.text = step.title
        self.descLabel.text = step.description
        self.urlLabel.text = step.url
        self.isSeeLess = step.isExpanded ?? false
        self.numeroDePassos.text = String(step.number)
        self.descLabel.numberOfLines = self.isSeeLess ? 0 : 3
        self.seeMoreButton.setTitle(self.isSeeLess ? "See less" : "See more", for: .normal)
        
        if self.descLabel.calculateMaxLines() < 3 {
            self.seeMoreButton.isHidden = true
        }

    }
    
}

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFontSize], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
