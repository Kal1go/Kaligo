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
            self.nextButton.layer.cornerRadius = 25
            self.nextButton.layer.masksToBounds = true
        }
    }
    
    var pageViewController: PageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard
            let numberOfVC = pageViewController?.orderedViewControllers.count,
            let index = pageViewController?.pageViewDelegate?.currentIndex
            else { return }
        
        switch index {
        case 0 ... (numberOfVC - 1):
            pageViewController?.forwardPage()
            
        case numberOfVC:
            dismiss(animated: true, completion: nil)
            
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
        case 0 ... (numberOfVC - 1):
            nextButton.setTitle("Próximo", for: .normal)
            skipButton.isHidden = false
            
        case 3:
            nextButton.setTitle("Começar", for: .normal)
            skipButton.isHidden = true
            
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
