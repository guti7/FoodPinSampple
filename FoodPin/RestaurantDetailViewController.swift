//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Guti on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    // MARK: - Variables
    @IBOutlet var restImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    
    var restImage: String! // = ""
    var nameRest: String!
    var locationRest: String!
    var typeRest: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        restImageView.image = UIImage(named: restImage)
        
        nameLabel.text = nameRest
        locationLabel.text = locationRest
        typeLabel.text = typeRest
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
