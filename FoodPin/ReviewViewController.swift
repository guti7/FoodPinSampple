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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // animation: minimize stack size
        let translation =  CGAffineTransform(translationX: 0.0, y: 500)
        let scaling = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        // you have to concatante a scale to a translation
        ratingStackView.transform = scaling.concatenating(translation)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // we want animation after view is loaded
        
//        UIView.animate(withDuration: 0.6, delay: 0.0, options: [], animations: {
//            self.ratingStackView.transform = CGAffineTransform.identity
//            }, completion: nil)
        
        UIView.animate(withDuration: 5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform.identity
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
