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
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        
        let title = result["thing"].string!
        let address = result["street"].string ?? nil
        let place = result["place"].string ?? nil
        let description = result["description"].string ?? nil
        let categories = result["Category"].string ?? nil
        let geoLat = result["lat"].double ?? 37.763299
        let geoLong = result["long"].double ?? -122.419356
        
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
        if categories != nil {
            categoriesLabel.text = categories!.capitalizedString
        } else { categoriesLabel.text = categories }
        descriptionLabel.text = description
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
        let title = result["thing"].string!
        let geoLat = result["lat"].double ?? 37.763299
        let geoLong = result["long"].double ?? -122.419356
        let addressDictionary = [String(CNPostalAddressStreetKey): title]
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(geoLat, geoLong), addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
    
    // MARK: Download Image
//    func downloadImage(url: NSURL){
//        print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
//        Utilities.getDataFromUrl(url) { (data, response, error)  in
//            dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                guard let data = data where error == nil else { return }
//                print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
//                self.imageView.image = UIImage(data: data)
//            }
//        }
//    }
    
    
}
