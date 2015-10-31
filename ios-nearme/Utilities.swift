//
//  Utilities.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/27/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation

public class Utilities  {
    
    public class func populateDistanceBetween(var results: JSON, currentLocation: CLLocation) -> JSON {
        for (key, _) in results {
            let intKey: Int = Int(key)!
            var thisItem: JSON = results[intKey]
            let geoLat = thisItem["place"][0]["location"]["geo"][1].double ?? 37.763299
            let geoLong = thisItem["place"][0]["location"]["geo"][0].double ?? -122.419356
            let destination = CLLocation(latitude: geoLat, longitude: geoLong)
            let distanceBetween: CLLocationDistance = destination.distanceFromLocation(currentLocation)
            thisItem["distance"].double =  distanceBetween
            results[intKey] = thisItem
        }
        return results
    }
    

    public class func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
}
