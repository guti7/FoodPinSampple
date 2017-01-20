//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Guti on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    var restaurant: Restaurant!
    
    // MARK:  - Outlets
    @IBOutlet var restImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var ratingButton: UIButton!
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set look and title of detail view
        title = restaurant.name
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.1)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)

        restImageView.image = UIImage(data: restaurant.image!)
        
        // self sizing cells
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let rating = restaurant.rating, rating != "" {
            ratingButton.setImage(UIImage(named: restaurant.rating!), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // make sure the navigation bar is always shown for this view
        navigationController?.hidesBarsOnSwipe = false
        navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Data Source Protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailRestaurantTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phoneNumber
        case 4:
            cell.fieldLabel.text = "Been here"
            if let isVisited = restaurant.isVisited?.boolValue {
                cell.valueLabel.text = isVisited ? "Yes, I've been here before" : "No"
            }
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }

    // MARK: - Navigation

    // Navigate to show map view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destination = segue.destination as! MapViewController
            destination.restaurant = self.restaurant
        }
    }
    
    
    // Unwind segue to close the review controller
    @IBAction func close(segue: UIStoryboardSegue) {
        
        // Closing from ReviewViewController
        if let reviewViewController = segue.source as? ReviewViewController {
            if let rating = reviewViewController.rating {
                restaurant.rating = rating
                ratingButton.setImage(UIImage(named: rating), for: UIControlState())
                
                if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
