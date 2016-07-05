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
        
        let title = result["name"].string ?? ""
        let id = result["id"].string ?? ""
        let name = result["name"].string ?? ""
        let lat = String(result["location"]["lat"]) ?? ""
        let long = String(result["location"]["lng"]) ?? ""
        
        let source = "webView"
        let address = result["location"]["address"].string ?? ""
        let categoryName = result["categories"][0]["name"].string ?? ""
        let city = result["location"]["city"].string ?? ""
        let country = result["location"]["country"].string ?? ""
        let phone = result["contact"]["phone"].string ?? ""
        let postalCode = result["location"]["postalCode"].string ?? ""
        let state = result["location"]["state"].string ?? ""
        let twitterId = result["contact"]["twitter"].string ?? ""
        let placeUrl = result["url"].string ?? ""
        
        let nameParam = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let addressParam = address.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let categoryNameParam = categoryName.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let cityParam = city.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let countryParam = country.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let placeUrlParam = placeUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        let baseUrl = "http://mapcat.io/ios/place/" + id + "/?name=" + nameParam!
        let paramOne = "&id=" + id + "&url=" + placeUrlParam!
        let paramTwo = "&lat=" + lat + "&long=" + long + "&source=" + source
        let paramThree =  "&categoryName=" + categoryNameParam! + "&city=" + cityParam!
        let paramFour = "&phone=" + phone + "&postalCode=" + postalCode + "&state=" + state + "&twitterId=" + twitterId
        let paramFive = "&address=" + addressParam! + "&country=" + countryParam!
        let postUrl = baseUrl + paramOne + paramTwo + paramThree + paramFour + paramFive
        
        let url = NSURL (string: postUrl);
        
        let requestObj = NSURLRequest(URL: url!);
        
        
        // set view
        navTitle.title = title.capitalizedString
        topThingsWebView.loadRequest(requestObj);
        

    }



}
