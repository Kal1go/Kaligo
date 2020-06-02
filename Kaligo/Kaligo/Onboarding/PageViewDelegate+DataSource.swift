//
//  PageViewDelegate+DataSource.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 01/06/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PageViewDelegateDataSource: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var currentIndex = 0
    
    weak var pageVC: PageViewController?
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageVC?.orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return pageVC?.setContentViewControler(at: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageVC?.orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1

        return pageVC?.setContentViewControler(at: nextIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
                
        guard
            let pageContentViewController = pageViewController.viewControllers?[0],
            let current = pageVC?.orderedViewControllers.firstIndex(of: pageContentViewController)
            else { return }
        
        self.currentIndex = current
        
        if let mVC = pageVC?.mainViewController {
            mVC.updateUI()
        }
    }
}
