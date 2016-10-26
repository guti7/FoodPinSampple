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
    var phoneNumber: String!
    var image: String!
    var isVisited: Bool
    var rating: String
    
    // initializer
    init(name: String, type: String, location: String, phoneNumber: String, image: String, isVisited: Bool = false, rating: String = "") {
        
        self.name = name
        self.type = type
        self.location = location
        self.phoneNumber = phoneNumber
        self.image = image
        self.isVisited = isVisited
        self.rating = rating
    }
}
