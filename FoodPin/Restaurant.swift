//
//  Restaurant.swift
//  FoodPin
//
//  Created by Guti on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import Foundation
import CoreData

// Managed object for Restaurant
class Restaurant: NSManagedObject {
    
    // Property corresponding to attributes in managed object model
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var phoneNumber: String?
    @NSManaged var image: Data? // NSData?
    @NSManaged var isVisited: NSNumber?
    @NSManaged var rating: String?

}
