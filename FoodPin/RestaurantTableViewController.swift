//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Guti on 10/22/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import CoreData


class RestaurantTableViewController: UITableViewController {
    

    // MARK: - Variables
    
    var restaurants: [Restaurant] = []
    var searchController: UISearchController! // used to add a search bar
    var searchResults: [Restaurant] = [] // store search results
  
    // Instance variable for the fetched results controller
    var fetchController: NSFetchedResultsController<NSManagedObject>!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - Search
    
    // Content filtering
    func filterContentForSearch(_ text: String) {
        // return true for values to be included
        searchResults = restaurants.filter() {
            (restaurant) -> Bool in
            
            let nameMatch = restaurant.name.range(of: text, options: .caseInsensitive)
            let locationMatch = restaurant.location.range(of: text, options: .caseInsensitive)
            
            return nameMatch != nil || locationMatch != nil
            
        }
    }
    
    
    // MARK: - View Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the title of the back button in destination controller
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        
        // self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // create and show search bar
        // TODO: - Keep list shown until typing is started in search bar
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        
        // customize search bar
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.orange
//        searchController.searchBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        
        
        
        // Fetch Core Data storage
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectConext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
            
            fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectConext, sectionNameKeyPath: nil, cacheName: nil)
            
            // Specify delegate for monitoring data changes
            fetchController.delegate = self
            
            do {
                try fetchController.performFetch()
                restaurants = fetchController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
        }
    }
    
    // The view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar when swiping on the table view
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // The view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if the walkthrough has been completed for the first time
        let defaults = UserDefaults.standard
        let isWalkthroughComplete = defaults.bool(forKey: "isWalkthroughComplete")
        if isWalkthroughComplete {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }
    

    // MARK: - Table view data source
   
    // Number of cell rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : restaurants.count
    }
    
    // Displays edit options for each row
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Share action for social networks
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let defaultText = "Just checking in at \(self.restaurants[indexPath.row].name)"
            
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!) {
            
                let activityCont = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityCont, animated: true, completion: nil)
            }
        }
        
        // Delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            // Delete the row from the data source and persitent store
            
            // Make sure to delete from your array data source first and then update table view
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
                let restaurantToDelete = self.fetchController.object(at: indexPath) as! Restaurant
                managedObjectContext.delete(restaurantToDelete)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
        
        // Configure look of the action buttons
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165/255, blue: 253/255, alpha: 1)
        
        // return the array of actions
        return [deleteAction, shareAction]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return !searchController.isActive
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        
        let restaurant = (searchController.isActive)  ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].image!)
        
        // using ternary conditional operator
        if let isVisited = restaurants[indexPath.row].isVisited?.boolValue {
            cell.accessoryType = isVisited ? .checkmark : .none
        }
        
        
        // Round Images
        // Can do it with Inteface builder too, with a runtime attribute for the imageview
        // as well as the clip to bounds property in the attributes drawing section
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds  = true
        
        return cell
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationCont = segue.destination as! RestaurantDetailViewController
                destinationCont.restaurant = (searchController.isActive) ? searchResults[indexPath.row] :restaurants[indexPath.row]
            }
        }
    }
    
    // Unwind from adding a new restaurant
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
} // end of class


// MARK: - Extensions

// The Protocol provides methods to notify its delegate whenever there are any changes
// in the controller's fetch results
extension RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    
    // Called whent the fetched results controller is about to start processing the content change.
    // "we're going to update the table. Get ready for it."
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // Called when there is any chang in the managed context (new restaurant is saved)
    // sync fetch resulss changes to your local data structure (restaurants)
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = newIndexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = newIndexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    // Called after the fetched results controller completes the change
    // Tells the table view that the update is completed and animates the change
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
} // end of NSFetchedResults


// Update and display the search results
extension RestaurantTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearch(searchText)
            tableView.reloadData()
        }
    }
}

