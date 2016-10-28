//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Guti on 10/27/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var locationField: UITextField!

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var isVisited: Bool = false
    
    
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
    
    
    
    
    // When row 1 is selected the photo library is shown.
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
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if sender.tag == 1 {
            // get values of text fields and validate text fields, if empty throw alert
            if ((nameField.text?.isEmpty)! || (typeField.text?.isEmpty)! || (locationField.text?.isEmpty)!) {
                print("UIAlertController added here")
                
                let alertMessage = UIAlertController(title: "Oops", message: "Can't proceed with blank fields.\nPlease fill all fields in.", preferredStyle: UIAlertControllerStyle.alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertMessage, animated: true, completion: nil)
                
            } else {  // else output to console
                print("------")
                print("All values:\nName - \(nameField.text!)\nType - \(typeField.text!)\nLocation - \(locationField.text!)\nHas Been Here - \(isVisited)")
                // TODO: Add restaurant to table view??
                performSegue(withIdentifier: "unwindHome", sender: self)
                // use dismissViewControllerAnimated(true, completion: nil)
            }
            
        }
    }
    
    
    
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
        
        // add layout contraints for the imageView
        // left
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
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
