//
//  SearchThreeViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit

class SearchThreeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var result: JSON = []
    var q: String = ""
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchThreeViewController Loaded")
        
        // set data
        let name = result["_id"]["name"].string ?? nil
        
        // set to UI
        nameLabel.text = name

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false // show the navigation controller top bar
    }


}
