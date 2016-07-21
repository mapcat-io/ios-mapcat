//
//  DetailViewController.swift
//  ios-nearme 
//
//  Created by Ryan Walton on 10/21/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
//import AddressBook
import CoreLocation
import Contacts

class DetailViewController: UIViewController {

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var result: JSON!
    var venuePhotos: JSON!
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        
        let title = Utilities.joinArrayWithSeparator(result["things"], separator: ", ")
        let address = result["locations"][0]["street"].string ?? nil
        let place = result["locations"][0]["name"].string ?? nil
        let description = Utilities.joinArrayWithSeparator(result["things"], separator: ", ")
        let categories = Utilities.joinArrayWithSeparator(result["categories"], separator: ", ")
        let geoLat = result["locations"][0]["lat"].double ?? 37.763299
        let geoLong = result["locations"][0]["long"].double ?? -122.419356
        
        // set initial location and boundary of map
        let location = CLLocation(latitude: geoLat, longitude: geoLong)
        centerMapOnLocation(location)
        
        // get distance to destination
        let destination = CLLocation(latitude: geoLat, longitude: geoLong)
        let setLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let distanceBetween: CLLocationDistance = destination.distanceFromLocation(setLocation)
        
        // set pin
        let pinLocation = CLLocationCoordinate2DMake(geoLat, geoLong)
        let dropPin = MKPointAnnotation()
        if (place != nil) {
            dropPin.title = place!
        }
        dropPin.coordinate = pinLocation
        mapView.addAnnotation(dropPin)
        
        // set labels
        navTitle.title = title.capitalizedString
        titleLabel.text = place
        addressLabel.text = address
        categoriesLabel.text = categories.capitalizedString
        descriptionLabel.text = description.capitalizedString
        distanceLabel.text = String(format: "%.1f mi away", distanceBetween * 0.000621371)
        
    }
    
    @IBAction func directionsButtonDidTouch(sender: AnyObject) {
        launchMaps()
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 250
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func launchMaps() {
        //set map item for directions button
        let title = Utilities.joinArrayWithSeparator(result["things"], separator: ", ")
        let geoLat = result["locations"][0]["lat"].double ?? 37.763299
        let geoLong = result["locations"][0]["long"].double ?? -122.419356
        let addressDictionary = [String(CNPostalAddressStreetKey): title]
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(geoLat, geoLong), addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
    
    
}
