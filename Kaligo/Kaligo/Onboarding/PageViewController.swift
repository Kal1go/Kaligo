//
//  PageViewController.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 01/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.instantiateNew(viewController: "tela1"),
                self.instantiateNew(viewController: "tela2"),
                self.instantiateNew(viewController: "tela3"),
                self.instantiateNew(viewController: "tela4")]
    }()
        
    weak var mainViewController: OnboardingViewController?
    
    var pageViewDelegate: PageViewDelegateDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.pageViewDelegate = PageViewDelegateDataSource()
        self.pageViewDelegate?.pageVC = self
        self.dataSource = pageViewDelegate
        self.delegate = pageViewDelegate
    }
    
    func instantiateNew(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func setContentViewControler(at index: Int) -> UIViewController? {
        if index < 0 || index >= orderedViewControllers.count {
            return nil
        }
        
        return orderedViewControllers[index]
    }
    
    func forwardPage() {
        self.pageViewDelegate?.currentIndex += 1
        
        guard let currentIndex = self.pageViewDelegate?.currentIndex else { return }
        
        if let nextViewController = setContentViewControler(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

}
