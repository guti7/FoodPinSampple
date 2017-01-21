//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Guti on 1/20/17.
//  Copyright © 2017 PielDeJaguar. All rights reserved.
//

import UIKit

// Manages multiple content pages for app walkthrough screens
class WalkthroughContentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!
    
    // current page index
    var index = 0
    var heading = ""
    var imageFile: UIImage! //= ""
    var content = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = imageFile //UIImage(named: imageFile)
        pageControl.currentPage = index
        
        // set up nextButton
        switch index {
        case 0, 1: nextButton.setTitle("NEXT", for: .normal)
        case 2: nextButton.setTitle("DONE", for: .normal)
        default: break
        }
        
    }
    
    // MARK: - Actions
    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
        case 0, 1:
            let pageViewController = parent as! WalkthroughPageViewController
                pageViewController.forward(index)
        case 2:
            
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "isWalkthroughComplete")
            
            dismiss(animated: true, completion: nil)
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
