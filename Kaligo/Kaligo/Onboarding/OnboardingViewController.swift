//
//  OnboardingViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 01/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 8
            self.nextButton.titleLabel?.adjustsFontSizeToFitWidth = true
            self.nextButton.titleLabel?.minimumScaleFactor = 0.5
            self.nextButton.titleLabel?.sizeToFit()
            self.nextButton.layer.masksToBounds = true
        }
    }
    
    var pageViewController: PageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        CommonData.isSawOndoarding = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard
            let numberOfVC = pageViewController?.orderedViewControllers.count,
            let index = pageViewController?.pageViewDelegate?.currentIndex
            else { return }
        
        switch index {
        case 0 ... (numberOfVC - 2):
            pageViewController?.forwardPage()
            
        case numberOfVC - 1:
            dismiss(animated: true, completion: nil)
            CommonData.isSawOndoarding = true
        default:
            break
        }
        updateUI()
    }
    
    func updateUI() {
        guard
            let numberOfVC = pageViewController?.orderedViewControllers.count,
            let index = pageViewController?.pageViewDelegate?.currentIndex
            else { return }
        
        switch index {
        case 0 ... (numberOfVC - 2):
            nextButton.setTitle("Próximo", for: .normal)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.skipButton.alpha = 1.0
            }, completion: { (true) in
                self.skipButton.isHidden = false
            })
            
        case numberOfVC - 1:
            nextButton.setTitle("Começar", for: .normal)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.skipButton.alpha = 0
            }, completion: { (true) in
                self.skipButton.isHidden = true
            })
            
        default:
            break
        }
        pageControl.currentPage = index
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pVC = destination as? PageViewController {
            pageViewController = pVC
            pVC.mainViewController = self 
        }
    }
}
