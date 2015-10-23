//
//  DetailViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/21/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var result: JSON!
    
    override func viewDidLoad() {
        
        let title = result["title"].string!
        let address = result["place"][0]["location"]["street1"].string ?? "address unknown"
        let place = result["place"][0]["title"].string ?? "Place unknown"
        let description = result["description"].string!
        let geoLat = result["place"][0]["location"]["geo"][1].double ?? 37.763299
        let geoLong = result["place"][0]["location"]["geo"][0].double ?? -122.419356
        
        // set initial location and boundary of map
        let location = CLLocation(latitude: geoLat, longitude: geoLong)
        centerMapOnLocation(location)
        
        // set pin
        let pinLocation = CLLocationCoordinate2DMake(geoLat, geoLong)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = pinLocation
        dropPin.title = place + ", " + address
        mapView.addAnnotation(dropPin)
        
        // set labels
        titleLabel.text = title
        addressLabel.text = place + ", " + address
        descriptionLabel.text = description
    }
    
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}
