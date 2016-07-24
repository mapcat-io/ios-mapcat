//
//  SearchOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit

class SearchOneViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBarView: DesignableView!
    @IBOutlet weak var searchTextField: DesignableTextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    var triggerKeyboard: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // handle keyboard delegate
        self.searchTextField.delegate = self
        self.searchTextField.returnKeyType = UIReturnKeyType.Go
        searchTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        // set UUID if new device
        let accounts = Accounts()
        accounts.setDeviceId()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true // hide the navigation controller top bar
        // trigger keyboard if needed
        if triggerKeyboard == true {
            self.searchTextField.becomeFirstResponder()
            triggerKeyboard = false
        }
    }
    
    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            self.performSegueWithIdentifier("SearchResultsSegue", sender: self)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            performSegueWithIdentifier("SearchResultsSegue", sender: self)
        }
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResultsSegue" {
            let toView = segue.destinationViewController as! SearchTwoViewController
            toView.q = self.searchTextField.text!
            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    
    @IBAction func unwindToSearch(segue: UIStoryboardSegue) {}
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
