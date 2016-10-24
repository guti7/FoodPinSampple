//
//  Restaurant.swift
//  FoodPin
//
//  Created by Guti on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import Foundation

class Restaurant {
    
    // Mark: - Instance Variables
    var name: String!
    var type: String!
    var location: String!
    var phone: String!
    var image: String!
    var isVisited: Bool = false
    
    // initializer
    init(name: String, type: String, location: String, phone: String, image: String, isVisited: Bool) {
        
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.isVisited = isVisited
    }
}
