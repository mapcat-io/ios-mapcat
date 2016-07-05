//
//  TopThingsViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/4/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation

class TopThingsViewController: UIViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var topThingsWebView: UIWebView!
    
    var result: JSON!
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        
        let title = result["name"].string!
        let id = result["id"].string!
        let name = result["name"].string!
        let lat = String(result["location"]["lat"])
        let long = String(result["location"]["lng"])
        
        let nameParam = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        let baseUrl = "http://www.mapcat.io/ios/place/" + id
        let paramOne = baseUrl + "/?name=" + nameParam! + "&id=" + id
        let postUrl = paramOne + "&lat=" + lat + "&long=" + long
        
        let url = NSURL (string: postUrl);
        
        let requestObj = NSURLRequest(URL: url!);
        
        
        // set view
        navTitle.title = title.capitalizedString
        topThingsWebView.loadRequest(requestObj);
        

    }



}
