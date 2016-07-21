//
//  SearchViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/20/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var currentLocation:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
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
        let location = CLLocation(latitude: lat!, longitude: long!)
        centerMapOnLocation(location)

    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 3000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }


}
