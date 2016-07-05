//
//  PlaceTableViewCell.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/4/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    

    func configureWithResult(result: JSON) {
        
        let title = result["name"].string!
        let address = result["location"]["address"].string ?? nil
        
        titleLabel.text = title
        addressLabel.text = address

        
    }

}
