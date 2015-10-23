//
//  ResultTableViewCell.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/20/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureWithResult(result: AnyObject) {
        
        let title = result["title"] as! String
        let address = result["place"]!![0]!["location"]!!["street1"]! as? String
        let description = result["description"] as! String
        
        titleLabel.text = title
        addressLabel.text = address
        descriptionLabel.text = description
        
        
    }

}
