//
//  HomeViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/16/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBarView: DesignableView!
    @IBOutlet weak var searchBar: SpringImageView!
    @IBOutlet weak var searchTextField: DesignableTextField!
    
    override func viewDidLoad() {
        
        // get users location
        activateLocationManager()
        
        // handle keyboard delegate
        self.searchTextField.delegate = self
        
    }

    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        searchCheckGo()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchSegue" {
            let toNav = segue.destinationViewController as! UINavigationController
            let toView = toNav.topViewController as! ResultsTableViewController
            toView.q = self.searchTextField.text!
            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchCheckGo()
        return true
    }
    
    // MARK: validate search and perform segue on button and return key
    func searchCheckGo() {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            performSegueWithIdentifier("SearchSegue", sender: self)
        }
    }
    
    // MARK: location function
    func activateLocationManager() {
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
    }

}
