//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Guti on 10/25/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var ratingStackView: UIStackView!
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var greatButton: UIButton!
    
    
    // MARK: - Variables
    var rating: String?
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add dark blurred background image view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // animation: for individual buttons
        let translate = CGAffineTransform(translationX: 0.0, y: 600.0)
        dislikeButton.transform = translate
        goodButton.transform  = translate
        greatButton.transform = translate
        
        // // animation: minimize stack size
        // let translation =  CGAffineTransform(translationX: 0.0, y: 500)
        // let scaling = CGAffineTransform(scaleX: 0.0, y: 0.0)
        // // you have to concatante a scale to a translation
        // ratingStackView.transform = scaling.concatenating(translation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Start the animation after the view is loaded
        
        // Animate dislikeButton
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.dislikeButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
        // Animate goodButton
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.goodButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
        // Animate greatButton
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.greatButton.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    
    // MARK: - Actions
    
    // Selects a rating from the available rating options and returns to the DetailView.
    @IBAction func ratingSelected(sender: UIButton) {
        switch sender.tag {
        case 100: rating = "dislike"
        case 200: rating = "good"
        case 300: rating = "great"
        default: break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
