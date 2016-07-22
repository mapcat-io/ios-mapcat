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
    
    var results: [JSON] = ["one", "two", "three"]
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        q = q.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/items", parameters: ["q" : q, "t": "aggregate"])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                if JSONObject["items"].count > 0 {
                    print("Results")
                }
                else {
                    print("No results")
                }
        }
        print("q for two: " + q)
        
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
