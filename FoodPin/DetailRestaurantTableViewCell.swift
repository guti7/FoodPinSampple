//
//  DetailRestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Guti on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class DetailRestaurantTableViewCell: UITableViewCell {
    
    
    // MARK: - Variables
    @IBOutlet var fieldLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
