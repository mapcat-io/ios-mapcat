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
    
    var result = [String:AnyObject]()
    
    override func viewDidLoad() {
        titleLabel.text = result["title"] as? String
    }
    
    
    
}
