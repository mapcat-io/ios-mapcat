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
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchTwoTableContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        searchTwoTableContainerView.alpha = 0 // set the container view to alpha zero with no results
        super.viewDidLoad()
        print("SearchTwoViewController Loaded")
        
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        mapView.showsUserLocation = true
        let location = CLLocation(latitude: lat!, longitude: long!)
        centerMapOnLocation(location)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false // show the navigation controller top bar
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchDetailsSegue" {
            let toView = segue.destinationViewController as! SearchThreeViewController
            toView.q = self.q
        }
        if segue.identifier == "SearchResultsEmbeddedSegue" {
            let toView = segue.destinationViewController as! SearchTwoTableViewController
            toView.q = self.q.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/items", parameters: ["q" : toView.q, "t": "aggregate"])
                .responseJSON { response in
                    let JSONObject = JSON(response.result.value!)
                    self.results = JSONObject["items"].arrayValue
                    toView.results = self.results
                    if JSONObject["items"].count > 0 {
                        print("Search Results Loaded. Perform Segue")
                        toView.tableView.reloadData()
                        self.searchTwoTableContainerView.alpha = 1 // display container view now with results
                    }
                    else {
                        print("No Results")
                    }
            }

        }
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 3000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}
