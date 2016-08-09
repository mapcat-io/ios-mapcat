//
//  SearchThreeViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Contacts
import Alamofire

class SearchThreeViewController: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var yelpButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yelpButtonHeightConstraint: NSLayoutConstraint!
    
    var result: JSON = []
    var placeItems: [JSON] = []
    var q: String = ""
    var annotation = MKPointAnnotation()
    var currentLocation: CLLocationCoordinate2D!
    var yelpUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // set data
        let name = result["_id"]["name"].string ?? nil
        let address = result["_id"]["street"].string ?? nil
        let lat = result["locations"][0]["lat"].double ?? nil
        let long = result["locations"][0]["long"].double ?? nil
        yelpUrl = result["locations"][0]["yelpUrl"].string ?? nil
        
        // update layout for non-existent values (baseline assumes values exist)
        if (address == nil) {
            addressLabel.removeFromSuperview()
            yelpButtonHeightConstraint.constant = 16
            contentHeightConstraint.constant -= 28
        }
        if (yelpUrl == nil) {
            yelpButton.removeFromSuperview()
            contentHeightConstraint.constant -= 48
        }
        
        let userLat = self.locationManager.location?.coordinate.latitude
        let userLong = self.locationManager.location?.coordinate.longitude
        
        // set initial location and boundary of map
        let destination = CLLocation(latitude: lat!, longitude: long!)
        mapView.showsUserLocation = true
        mapView.layer.addBorder(UIRectEdge.Bottom, color: UIColor(hexString: "#CECED2"), thickness: 2)
        centerMapOnLocation(destination)
        
        let request = MKDirectionsRequest()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: long!), addressDictionary: nil))
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: userLat!, longitude: userLong!), addressDictionary: nil))
        request.requestsAlternateRoutes = false
        request.transportType = .Automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 51.0, left: 16.0, bottom: 51.0, right: 16.0), animated: true)
            }
        }
        
        // set pin
        let pinLocation = CLLocationCoordinate2DMake(lat!, long!)
        let dropPin = MKPointAnnotation()
        dropPin.title = name
        dropPin.coordinate = pinLocation
        mapView.addAnnotation(dropPin)
        
        // set to UI
        navTitle.title = name
        nameLabel.text = name
        addressLabel.text = address
        

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false // show the navigation controller top bar
    }
    
    @IBAction func directionsButtonDidTouch(sender: AnyObject) {
        launchMaps()
    }
    
    @IBAction func yelpButtonDidTouch(sender: AnyObject) {
        if (self.yelpUrl != nil) {
            UIApplication.sharedApplication().openURL(NSURL(string: self.yelpUrl!)!)
        }
        else {
            // do nothing
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FormEmbeddedSegue" {
            let toView = segue.destinationViewController as! SearchThreeFormViewController
            toView.items = self.result["things"]
            toView.name = (self.result["_id"]["name"].string ?? nil)!
        }
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 250
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor(red:0.92, green:0.36, blue:0.56, alpha:1.0)
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return renderer
    }
    
    func launchMaps() {
        //set map item for directions button
        let name = result["_id"]["name"].string
        let lat = result["locations"][0]["lat"].double ?? nil
        let long = result["locations"][0]["long"].double ?? nil
        let addressDictionary = [String(CNPostalAddressStreetKey): String(name)]
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(lat!, long!), addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }


}
