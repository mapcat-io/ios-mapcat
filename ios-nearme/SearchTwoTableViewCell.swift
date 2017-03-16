//
//  SearchTwoTableViewCell.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit

class SearchTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var thingsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWithResult(_ result: JSON) {
        
        // set data
        let name = result["_id"]["name"].string ?? nil
        let distance = result["distance"][0].double ?? nil
        let things = Utilities.joinArrayWithSeparator(result["things"], separator: ", ").capitalized
        
        // set to UI
        nameLabel.text = name
        distanceLabel.text = String(format: "%.1f mi", distance! * 0.000621371)
        thingsLabel.text = things
    }

}
