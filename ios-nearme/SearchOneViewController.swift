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
import Spring

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchOneViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchOneViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // set UUID if new device
        let accounts = Accounts()
        accounts.setDeviceId()
        
        // ask for authorization
//        self.locationManager.requestAlwaysAuthorization() // don't request this set of permissions
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
        self.searchTextField.returnKeyType = UIReturnKeyType.go
        searchTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true // hide the navigation controller top bar
        
        // TODO: fix issue with this animation
        // searchBarView.animation = "zoomIn"
        // searchBarView.animate()
        
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
    
    @IBAction func searchButtonDidTouch(_ sender: AnyObject) {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            self.performSegue(withIdentifier: "SearchResultsSegue", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            searchBarView.animation = "shake"
            searchBarView.animate()
        }
        else {
            performSegue(withIdentifier: "SearchResultsSegue", sender: self)
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchResultsSegue" {
            let toView = segue.destination as! SearchTwoViewController
            toView.q = self.searchTextField.text!
            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    
    @IBAction func unwindToSearch(_ segue: UIStoryboardSegue) {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        // keyboard will show
//        searchBarHeightConstraint.constant = 44
    }
    
    func keyboardWillHide(_ notification:Notification) {
        // keyboard will hide
//        searchBarHeightConstraint.constant = 88
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // handles success/failure of location authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
            let alertController = UIAlertController(title: "😿", message:
                "We need your location to find things around you.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Enable in Settings", style: UIAlertActionStyle.default, handler:  { action in
                if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(settingsURL)
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // User accepted authorization
            let lat = locationManager.location?.coordinate.latitude // 37.7557675
            let long = locationManager.location?.coordinate.longitude // -122.4246298
            mapView.showsUserLocation = (status == .authorizedWhenInUse)
            let location = CLLocation(latitude: lat!, longitude: long!)
            centerMapOnLocation(location)
        }
    }

}
