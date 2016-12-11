//
//  AddOneTableViewCell.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddOneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    func configureWithResult(_ result: JSON) {
        
        let name = result["name"].string!
        let address = result["location"]["address"].string ?? nil
        
        nameLabel.text = name
        addressLabel.text = address
        
        
    }

}
