//
//  SearchOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class SearchOneViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchOneViewController Loaded")
        
    }
    
    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        q = q.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/items", parameters: ["q" : q, "t": "aggregate"])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.results = JSONObject["items"].arrayValue
//                print(self.results)
                if JSONObject["items"].count > 0 {
                    print("Search Results Loaded. Perform Segue")
                    self.performSegueWithIdentifier("SearchResultsSegue", sender: self)
                }
                else {
                    print("No Results")
                }
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResultsSegue" {
            let toView = segue.destinationViewController as! SearchTwoViewController
            toView.q = "beer"
            toView.results = self.results
        }
    }
    

}
