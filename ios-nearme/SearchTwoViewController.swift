//
//  SearchTwoViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class SearchTwoViewController: UIViewController, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var searchTwoTableContainerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        searchTwoTableContainerView.alpha = 0 // set the container view to alpha zero with no results
        super.viewDidLoad()
        print("SearchTwoViewController Loaded")
        
        mapView.delegate = self
        
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        mapView.showsUserLocation = true
        let location = CLLocation(latitude: lat!, longitude: long!)
        centerMapOnLocation(location)
        
        // set labels
        navTitle.title = q.capitalizedString
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false // show the navigation controller top bar
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResultsSegue" {
            if let destination = segue.destinationViewController as? SearchThreeViewController, let annotationView = sender as? MKPinAnnotationView {
                destination.result = self.results[Int(annotationView.reuseIdentifier!)!]
                destination.q = self.q
            }
        }
        if segue.identifier == "SearchResultsEmbeddedSegue" {
            let toView = segue.destinationViewController as! SearchTwoTableViewController
            toView.q = self.q.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/items", parameters: ["q" : toView.q, "t": "aggregate"])
                .responseJSON { response in
                    let JSONObject = JSON(response.result.value!)
                    self.results = JSONObject["items"].arrayValue
                    toView.results = self.results
                    if JSONObject["items"].count > 0 {
                        print("Search Results Loaded. Perform Segue")
                        toView.tableView.reloadData()
                        self.searchTwoTableContainerView.alpha = 1 // display container view now with results
                        // add map pins to mapView
                        var counter: Int = 0
                        for (_, subJson) in JSONObject["items"] {
                            let lat = subJson["locations"][0]["lat"].double
                            let long = subJson["locations"][0]["long"].double
                            let pinLocation = CLLocationCoordinate2DMake(lat!, long!)
                            let title = subJson["_id"].string
                            let dropPin = CustomAnnotation(coordinate: pinLocation, title: title!, id: String(counter))
                            self.mapView.addAnnotation(dropPin)
                            counter += 1
                        }
                
                    }
                    else {
                        print("No Results")
                    }
            }

        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var scrollOffset = scrollView.contentOffset.y
        var headerFrame = searchTwoTableContainerView.frame
        if (scrollOffset < 0) {
            // Adjust container
            headerFrame = CGRect(x: searchTwoTableContainerView.frame.origin.x,
                                 y: searchTwoTableContainerView.frame.origin.y,
                                 width: searchTwoTableContainerView.frame.size.width,
                                 height: -scrollOffset)
        } else {
            // Adjust container
            headerFrame = CGRect(x: searchTwoTableContainerView.frame.origin.x,
                                 y: searchTwoTableContainerView.frame.origin.y,
                                 width: searchTwoTableContainerView.frame.size.width,
                                 height: 0)
        }
        searchTwoTableContainerView.frame = headerFrame
    }
    
    // MARK: MKMapView Helper Methods
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 3.0, regionRadius * 3.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegueWithIdentifier("SearchResultsSegue", sender: view)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        // to get the identifier of the pin to segue to SearchResultsSegue
        let customAnnotation = annotation as? CustomAnnotation
        let identifier = customAnnotation!.id! as String
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .InfoLight)
        } else {
            annotationView?.annotation = annotation
        }
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
