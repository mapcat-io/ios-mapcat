//
//  DetailViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/21/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var result: JSON!
    
    override func viewDidLoad() {
        titleLabel.text = result["title"].string!
        addressLabel.text = result["place"][0]["location"]["street1"].string!
        descriptionLabel.text = result["description"].string!
    }
    
    
    
}
