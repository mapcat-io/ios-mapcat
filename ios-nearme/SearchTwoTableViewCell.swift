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

    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWithResult(result: JSON) {
        
        // set data
        let name = result["_id"].string ?? nil
        
        // set to UI
        nameLabel.text = name
    }

}
