//
//  SearchOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import KeychainAccess
import Accounts

class SearchOneViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBarView: DesignableView!
    @IBOutlet weak var searchTextField: DesignableTextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    var triggerKeyboard: Bool = false
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchOneViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchOneViewController.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        // set UUID if new device
        let accounts = Accounts()
        accounts.setDeviceId()
        
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
        
        super.viewDidLoad()
        
        // handle keyboard delegate
        self.searchTextField.delegate = self
        self.searchTextField.returnKeyType = UIReturnKeyType.Go
        searchTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true // hide the navigation controller top bar
        
        searchBarView.animation = "zoomIn"
        searchBarView.animate()
        
        // trigger keyboard if needed
        if triggerKeyboard == true {
            self.searchTextField.becomeFirstResponder()
            triggerKeyboard = false
        }
        // update location
//        let lat = locationManager.location?.coordinate.latitude
//        let long = locationManager.location?.coordinate.longitude
//        mapView.showsUserLocation = true
//        let location = CLLocation(latitude: lat!, longitude: long!)
//        centerMapOnLocation(location)
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
    
    func keyboardWillShow(notification:NSNotification) {
        // keyboard will show
//        searchBarHeightConstraint.constant = 44
    }
    
    func keyboardWillHide(notification:NSNotification) {
        // keyboard will hide
//        searchBarHeightConstraint.constant = 88
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // handles success/failure of location authorization
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.Denied) {
            // The user denied authorization
            let alertController = UIAlertController(title: "😿", message:
                "We need your location to find things around you.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Enable in Settings", style: UIAlertActionStyle.Default, handler:  { action in
                if let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(settingsURL)
                }
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if (status == CLAuthorizationStatus.AuthorizedAlways) {
            // User accepted authorization
            let lat = locationManager.location?.coordinate.latitude
            let long = locationManager.location?.coordinate.longitude
//            mapView.showsUserLocation = true
            mapView.showsUserLocation = (status == .AuthorizedAlways)
            let location = CLLocation(latitude: lat!, longitude: long!)
            centerMapOnLocation(location)
        }
    }
    
//    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // needed to update map on return
//    }
    

}
