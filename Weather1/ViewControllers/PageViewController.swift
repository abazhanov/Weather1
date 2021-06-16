//
//  PageViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 27.05.2021.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PageViewController")
        self.dataSource = self
        
        if let vc = returnPageViewController(for: 1) {
            setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
        
        
        
//        setViewControllers([returnPageViewController(for: 1)], direction: .forward, animated: false) { (bool) in
//            <#code#>
//        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return returnPageViewController(for: 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return returnPageViewController(for: 1)
    }

    func returnPageViewController(for index: Int) -> MainViewController? {
        let navVC = storyboard?.instantiateViewController(withIdentifier: "navVC") as! UINavigationController
        let vc = navVC.topViewController as! MainViewController
        print("VC = ", vc)
        return vc
    }
}
