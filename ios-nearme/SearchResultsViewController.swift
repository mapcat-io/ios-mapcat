//
//  SearchResultsViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/21/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit

class SearchResultsViewController: UIViewController {
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
