//
//  SearchOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit

class SearchOneViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("q for one (nil): " + q)
    }
    
    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("SearchResultsSegue", sender: self)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResultsSegue" {
            let toView = segue.destinationViewController as! SearchTwoViewController
            toView.q = "beer"
//            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    

}
