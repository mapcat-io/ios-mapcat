//
//  HomeViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/16/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBar: SpringImageView!
    @IBOutlet weak var searchTextField: DesignableTextField!
    
    override func viewDidLoad() {
        
        // Ask for Authorization from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }

    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        if self.searchTextField.text == "" {
            searchBar.animation = "shake"
            searchBar.animate()
        }
        else {
            performSegueWithIdentifier("SearchSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchSegue" {
            let toNav = segue.destinationViewController as! UINavigationController
            let toView = toNav.topViewController as! ResultsTableViewController
            toView.q = self.searchTextField.text!
            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }

}
