//
//  SearchOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit

class SearchOneViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchOneViewController Loaded")
        
        // ask for authorization
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        // update location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        mapView.showsUserLocation = true
        let location = CLLocation(latitude: lat!, longitude: long!)
        centerMapOnLocation(location)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true // hide the navigation controller top bar
    }
    
    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        self.performSegueWithIdentifier("SearchResultsSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResultsSegue" {
            let toView = segue.destinationViewController as! SearchTwoViewController
            toView.q = "beer"
            toView.currentLocation = locationManager.location!.coordinate
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
