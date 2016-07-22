//
//  SearchThreeViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit

class SearchThreeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var result: JSON = []
    var q: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("q for three: " + q)
        
        // set data
        let name = result.string ?? nil
        
        // set to UI
        nameLabel.text = name

    }


}
