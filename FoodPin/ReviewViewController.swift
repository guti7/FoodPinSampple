//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Guti on 10/25/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var ratingStackView: UIStackView!
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var greatButton: UIButton!
    
    var rating: String?
    
    // Performed when user selects a rating from the proposed ratings.
    @IBAction func ratingSelected(sender: UIButton) {
        switch sender.tag {
        case 100: rating = "dislike"
        case 200: rating = "good"
        case 300: rating = "great"
        default: break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
//        // animation: minimize stack size
//        let translation =  CGAffineTransform(translationX: 0.0, y: 500)
//        let scaling = CGAffineTransform(scaleX: 0.0, y: 0.0)
//        
//        // you have to concatante a scale to a translation
//        ratingStackView.transform = scaling.concatenating(translation)
        
        // animation: for individual buttons
        let translate = CGAffineTransform(translationX: 0.0, y: 500.0)
        dislikeButton.transform = translate
        goodButton.transform  = translate
        greatButton.transform = translate
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // we want animation after view is loaded
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.dislikeButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.goodButton.transform = CGAffineTransform.identity
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.greatButton.transform = CGAffineTransform.identity
            }, completion: nil)
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
