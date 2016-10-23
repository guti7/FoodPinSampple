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
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
                           "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
                           "Bourke Street Bakery", "Haigh's Chocolate",
                           "Palomino Espresso", "Upstate", "Traif",
                           "Graham Avenue Meats", "Waffle & Wolf",
                           "Five Leaves", "Cafe Lore", "Confessional",
                           "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg",
                            "cafeloisl.jpg", "petiteoyster.jpg",
                            "forkeerestaurant.jpg", "posatelier.jpg",
                            "bourkestreetbakery.jpg", "haighschocolate.jpg",
                            "palominoespresso.jpg", "upstate.jpg", "traif.jpg",
                            "grahamavenuemeats.jpg", "wafflewolf.jpg",
                            "fiveleaves.jpg", "cafelore.jpg",
                            "confessional.jpg", "barrafina.jpg",
                            "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong",
                               "Hong Kong","Hong Kong", "Hong Kong",
                               "Hong Kong", "Sydney", "Sydney", "Sydney",
                               "NewYork", "New York", "New York", "New York",
                               "New York", "New York", "New York", "London",
                               "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House",
                           "Austrian / Causual Drink", "French", "Bakery",
                           "Bakery", "Chocolate", "Cafe", "American / Seafood",
                           "American", "American", "Breakfast & Brunch",
                           "Coffee & Tea", "Coffee & Tea", "Latin American",
                           "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = [Bool](repeating: false, count: 21)

    
    
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
            let defaultText = "Just checking in at \(self.restaurantNames[indexPath.row])"
            
            if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
            
                let activityCont = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityCont, animated: true, completion: nil)
            }
        }
        
        // Delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {(action, indexPath) in
            let index = indexPath.row
            self.restaurantNames.remove(at: index)
            self.restaurantLocations.remove(at: index)
            self.restaurantTypes.remove(at: index)
            self.restaurantIsVisited.remove(at: index)
            self.restaurantImages.remove(at: index)
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
            let index = indexPath.row
            restaurantNames.remove(at: index)
            restaurantLocations.remove(at: index)
            restaurantTypes.remove(at: index)
            restaurantIsVisited.remove(at: index)
            restaurantImages.remove(at: index)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        //tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        
        // using ternary conditional operator
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        
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
        
        if segue.identifier == "showRestDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationCont = segue.destination as! RestaurantDetailViewController
                destinationCont.restImage = restaurantImages[indexPath.row]
                destinationCont.nameRest = restaurantNames[indexPath.row]
                destinationCont.locationRest = restaurantLocations[indexPath.row]
                destinationCont.typeRest = restaurantTypes[indexPath.row]
            }
        }
    }

}
