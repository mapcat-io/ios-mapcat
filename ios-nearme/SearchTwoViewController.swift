//
//  SearchTwoViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Mapcat. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import Flurry_iOS_SDK

class SearchTwoViewController: UIViewController, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var searchTwoTableContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        
        Flurry.logEvent("SearchResults_View", timed: true)
        
        searchTwoTableContainerView.alpha = 0 // set the container view to alpha zero with no results
        mapView.layer.addBorder(UIRectEdge.bottom, color: UIColor(hexString: "#CECED2"), thickness: 2)
        
        super.viewDidLoad()
        // animate spinner
        activityIndicator.startAnimating()
        
        mapView.delegate = self
        
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        mapView.showsUserLocation = true
        let location = CLLocation(latitude: lat!, longitude: long!)
        centerMapOnLocation(location)
        
        // set labels
        navTitle.title = q.capitalized
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false // show the navigation controller top bar
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchResultsSegue" {
            if let destination = segue.destination as? SearchThreeViewController, let annotationView = sender as? MKPinAnnotationView {
                destination.result = self.results[Int(annotationView.reuseIdentifier!)!]
                destination.q = self.q
            }
        }
        if segue.identifier == "SearchResultsEmbeddedSegue" {
            let toView = segue.destination as! SearchTwoTableViewController
            toView.q = self.q.trimmingCharacters(in: CharacterSet.whitespaces)
            Alamofire.request("http://104.196.227.137:3911/api/v2/items", parameters: ["q" : toView.q, "long": self.currentLocation.longitude, "lat": self.currentLocation.latitude, "token": "N2ax2YzrL5MkY0WAIpKEWv2EGA8D4eqp"])
                .responseJSON { response in
                    var JSONObject = JSON(response.result.value!)
                    self.results = JSONObject["items"].arrayValue
                    if JSONObject["items"].count > 0 {
                        //= add map pins to mapView
                        var counter: Int = 0
                        for item in self.results {
                            let lat = item["coordinates"][1].double
                            let long = item["coordinates"][0].double
                            let pinLocation = CLLocationCoordinate2DMake(lat!, long!)
                            let title = item["_id"]["name"].string ?? "No Name"
                            let dropPin = CustomAnnotation(coordinate: pinLocation, title: title, id: String(counter))
                            self.mapView.addAnnotation(dropPin)
                            counter += 1
                        }
                        // remove spinner
                        self.activityIndicator.stopAnimating()
                        // provide data to view
                        toView.results = self.results
                        // reload view
                        toView.tableView.reloadData()
                        // display results
                        self.searchTwoTableContainerView.alpha = 1 // display container view now with results
                        Flurry.logEvent("Search_Results", withParameters: ["q": self.q, "lat": self.locationManager.location!.coordinate.latitude, "long": self.locationManager.location!.coordinate.longitude, "itemsCount": self.results.count])
                    } else {
                        //= no results
                        // remove spinner
                        self.activityIndicator.stopAnimating()
                        let alertController = UIAlertController(title: "😿", message:
                            "There are no results.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:  { action in self.performSegue(withIdentifier: "unwindToSearch", sender: self) }))
                        self.present(alertController, animated: true, completion: nil)
                        Flurry.logEvent("Search_Results", withParameters: ["q": self.q, "lat": self.locationManager.location!.coordinate.latitude, "long": self.locationManager.location!.coordinate.longitude, "itemsCount": 0])
                    }
            }

        }
        if segue.identifier == "unwindToSearch" {
            let toView = segue.destination as! SearchOneViewController
            toView.triggerKeyboard = true
            toView.q = ""
        }
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 3000
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "SearchResultsSegue", sender: view)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        // to get the identifier of the pin to segue to SearchResultsSegue
        let customAnnotation = annotation as? CustomAnnotation
        let identifier = customAnnotation!.id! as String
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView!.image = UIImage(named: "mapcat_face")
        return annotationView
    }
    
}

class CustomAnnotation : NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var id: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, id: String) {
        self.coordinate = coordinate
        self.title = title
        self.id = id
        
    }
}
