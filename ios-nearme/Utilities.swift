//
//  Utilities.swift
//  ios-nearme
//
//  Created by Jen Long on 6/1/16.
//  Copyright © 2016 Mapcat.io. All rights reserved.
//

import UIKit
import CoreLocation

public class Utilities  {
    
    public class func populateDistanceBetween(var results: JSON, currentLocation: CLLocation) -> JSON {
        for (key, _) in results {
            let intKey: Int = Int(key)!
            var thisItem: JSON = results[intKey]
            let geoLat = thisItem["lat"].double ?? 37.763299
            let geoLong = thisItem["long"].double ?? -122.419356
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
