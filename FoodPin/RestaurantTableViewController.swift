//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Guti on 10/22/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    
    // MARK: - Variables
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    var restaurants: [Restaurant] = [
            Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend.jpg", isVisited: false),
            Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong",
                       image: "homei.jpg", isVisited: false),
            Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong",
                       image: "teakha.jpg", isVisited: false),
            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location:"Hong Kong", image: "cafeloisl.jpg", isVisited: false),
            Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong",
                       image: "petiteoyster.jpg", isVisited: false),
            Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong",
                       image: "forkeerestaurant.jpg", isVisited: false),
            Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong",
                       image: "posatelier.jpg", isVisited: false),
            Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:
                    "Sydney", image: "bourkestreetbakery.jpg", isVisited: false),
            Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney",
                       image: "haighschocolate.jpg", isVisited: false),
            Restaurant(name: "Palomino Espresso", type: "American / Seafood", location:
                    "Sydney", image: "palominoespresso.jpg", isVisited: false),
            Restaurant(name: "Upstate", type: "American", location: "New York", image:
                    "upstate.jpg", isVisited: false),
            Restaurant(name: "Traif", type: "American", location: "New York", image:
                    "traif.jpg", isVisited: false),
            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats.jpg", isVisited: false),
            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York",
                    image: "wafflewolf.jpg", isVisited: false),
            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York",
                        image: "fiveleaves.jpg", isVisited: false),
            Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York",
                               image: "cafelore.jpg", isVisited: false),
            Restaurant(name: "Confessional", type: "Spanish", location: "New York",
                               image: "confessional.jpg", isVisited: false),
            Restaurant(name: "Barrafina", type: "Spanish", location: "London", image:
                        "barrafina.jpg", isVisited: false),
            Restaurant(name: "Donostia", type: "Spanish", location: "London", image:
                        "donostia.jpg", isVisited: false),
            Restaurant(name: "Royal Oak", type: "British", location: "London", image:  "royaloak.jpg", isVisited: false),
            Restaurant(name: "Thai Cafe", type: "Thai", location: "London", image:
                "thaicafe.jpg", isVisited: false)
        ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Sharing in Social button
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let defaultText = "Just checking in at \(self.restaurants[indexPath.row].name)"
            
            if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) {
            
                let activityCont = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityCont, animated: true, completion: nil)
            }
        }
        
        // Delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {(action, indexPath) in
            
            // Delete row from data source
            self.restaurants.remove(at: indexPath.row)
            
            // Update table view
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165/255, blue: 253/255, alpha: 1)
        
        return [deleteAction, shareAction]
    }
    
    // Enables swipe-to-x feature of the table view (from dataSource protocol)
    // the table view automatically displays a "Delete" button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // delete row for data source
            restaurants.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        //tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.thumbnailImageView.image = UIImage(named: restaurant.image)
        
        // using ternary conditional operator
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        // Round Images
        // Can do it with Inteface builder too check out the runtime attribute for the imageview, and also the clip to bounds property in the attributes drawing section
//        cell.thumbnailImageView.layer.cornerRadius = 45.0
//        cell.thumbnailImageView.clipsToBounds  = true
        

        return cell
    }
    
    // MARK: - Table View Delegate Protocol
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        // Create action sheet alert menu
//        let optionMenu = UIAlertController(title: "Next:", message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.actionSheet)
//        
//        // call Action handler
//        let callActionHandler = { (action: UIAlertAction!) in
//            let alertMessage = UIAlertController(title: "Service Unavailable",
//                                                 message: "Sorry, the call feature is not available yet. Please retry later.",
//                                                 preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alertMessage, animated: true, completion: nil)
//        }
//        
//        
//        // create actions for the menu so the user can respond
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
//        
//        let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
//        
//        let visitedTitle = restaurantIsVisited[indexPath.row] ? "I've not visited here" : "I've visited here"
//        
//        let visitedAction = UIAlertAction(title: visitedTitle, style: .default, handler: {
//            (action: UIAlertAction!) -> Void in
//            let cell = tableView.cellForRow(at: indexPath)
//            if self.restaurantIsVisited[indexPath.row] {
//                cell?.accessoryType = .none
//                self.restaurantIsVisited[indexPath.row] = false
//            } else {
//                cell?.accessoryType = .checkmark
//                self.restaurantIsVisited[indexPath.row] = true
//            }
//        })
//        
////        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive, handler: nil)
//        
//        // Add the actions to the menu
//        optionMenu.addAction(cancelAction)
//        
//        optionMenu.addAction(callAction)
//        optionMenu.addAction(visitedAction)
//        
////        optionMenu.addAction(destructiveAction)
//        
//        
//        present(optionMenu, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationCont = segue.destination as! RestaurantDetailViewController
                destinationCont.restaurant = restaurants[indexPath.row]
            }
        }
    }
} // end of class
