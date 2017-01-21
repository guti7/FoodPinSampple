//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Guti on 1/20/17.
//  Copyright © 2017 PielDeJaguar. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    
    // MARK: - Variables
    
    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = [#imageLiteral(resourceName: "foodpin-intro-1"), #imageLiteral(resourceName: "foodpin-intro-2"), #imageLiteral(resourceName: "foodpin-intro-3")]
    var pageContent = ["Pin your favorite restaurants and create your own food guide", "Search and locate your favorite restaurant on Maps", "Find restaurants pinned by your friends and other foodies around the world"]
    
    
    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set data source to self
        dataSource = self
        
        // Create the first walkthrough scene
        if let startingViewController = viewControllerAt(0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    
    // MARK: - UIPageViewControllerDataSource 
    
    // Get the next view controller with content
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // get the index of the currently displayed view controller
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return viewControllerAt(index)
    }
    
    // Get the previous view controller with content
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return viewControllerAt(index)
    }
    
    
    // MARK: - Helpers
    
    // Shows the next view controller
    func forward(_ index: Int) {
        if let nextViewController = viewControllerAt(index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Creates the page content view controler
    func viewControllerAt(_ index: Int) -> WalkthroughContentViewController? {
        
        // check for invalid indexv values
        if index == NSNotFound || index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller with suitable data
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentVC") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
