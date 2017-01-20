//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Guti on 10/27/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import CoreData

// Add a new restaurant to data model
class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var phoneField: UITextField!

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    // MARK: - Variables
    var restaurant: Restaurant!
    var isVisited: Bool = false
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // When the first row is selected the photo library is shown.
    override func tableView(_ tableView: UITableView, didSelectRowAt index: IndexPath) {
        if index.row == 0 {
            
            // Check if the user has given access to photo library
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary // default value
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRow(at: index, animated: true)
    }
    
    
    // MARK: - Actions
    
    // Save the restaurant
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let name = nameField.text
        let type = typeField.text
        let location = locationField.text
        let phoneNumber = phoneField.text
        
        // Validate input fields
        if name == "" || type == "" || location == "" || phoneNumber == "" {
            let alertController = UIAlertController(title: "Oops", message: "One or more of the fields are blank. Please note all fields are required.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)) // nothing to do just dimsiss alert when OK is pressed
            
            self.present(alertController, animated: true, completion: nil)
            
            return
            
        } else { // user input data is valid so attempt to save to persistent store
            
            if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
                
                restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: managedObjectContext) as! Restaurant
                restaurant.name = name!
                restaurant.type = type!
                restaurant.location = location!
                restaurant.phoneNumber = phoneNumber!
                
                
                if let restaurantImage = self.imageView.image {
                    restaurant.image = UIImagePNGRepresentation(restaurantImage)
                }
                
                restaurant.isVisited = self.isVisited as NSNumber?                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Error: \(error)")
                    return
                }
            }
        }
        
        // Dismiss the current view controller
        dismiss(animated: true, completion: nil)
    }
    
    // Toggle yes no if you have visited this restaurant
    @IBAction func hasBeenHere(_ sender: UIButton) {
        if sender == yesButton { // sender == yesButton ?
            yesButton.backgroundColor = .red
            noButton.backgroundColor = .darkGray
            isVisited = true
        } else if sender == noButton { // noButon was tapped
            yesButton.backgroundColor = .darkGray
            noButton.backgroundColor = .red
            isVisited = false
        }
    }
    
    
    // MARK: - UIImagePickerControllerDelegate
    
    // Get the selected photo once the user chooses a photo
    // Assigns the image view with the selecte image.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        
        // add layout contraints for the imageView, left
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        // right
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        // top
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        // bottom
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
}
