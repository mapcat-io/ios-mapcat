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
    
    var result = [String:AnyObject]()
    
    override func viewDidLoad() {
        titleLabel.text = result["title"] as? String
        addressLabel.text = result["place"]![0]!["location"]!!["street1"]! as? String
        descriptionLabel.text = result["description"] as? String
    }
    
    
    
}
