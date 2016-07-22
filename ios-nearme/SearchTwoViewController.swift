//
//  SearchTwoViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class SearchTwoViewController: UIViewController {
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchTwoViewController Loaded")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchDetailsSegue" {
            let toView = segue.destinationViewController as! SearchThreeViewController
            toView.q = self.q
        }
        if segue.identifier == "SearchResultsEmbeddedSegue" {
            let toView = segue.destinationViewController as! SearchTwoTableViewController
            toView.q = "beer"
            toView.results = self.results
        }
    }
    

}
