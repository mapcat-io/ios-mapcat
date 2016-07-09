//
//  HomeViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/16/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation
import KeychainAccess
import Accounts

class HomeViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBarView: DesignableView!
    @IBOutlet weak var searchBar: SpringImageView!
    @IBOutlet weak var searchTextField: DesignableTextField!
    
    override func viewDidLoad() {
        
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
        
        // handle keyboard delegate
        self.searchTextField.delegate = self
        
        // set UUID if new device
        let accounts = Accounts()
        accounts.setDeviceId()
        
    }

    // search to tableviewcontroller actions
    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            performSegueWithIdentifier("SearchSegue", sender: self)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            performSegueWithIdentifier("SearchSegue", sender: self)
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchSegue" {
            let toNav = segue.destinationViewController as! UINavigationController
            let toView = toNav.topViewController as! ResultsTableViewController
            toView.q = self.searchTextField.text!
            toView.currentLocation = locationManager.location!.coordinate
        }
        if segue.identifier == "AddSegue" {
            let toNav = segue.destinationViewController as! UINavigationController
            let toView = toNav.topViewController as! PlacesTableViewController
            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }

}
