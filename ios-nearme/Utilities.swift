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
            let geoLat = thisItem["locations"][0][1].double ?? 37.763299
            let geoLong = thisItem["locations"][0][0].double ?? -122.419356
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
    
    // return string from JSONSwifty Array object, with seperator
    public class func joinArrayWithSeparator(data: JSON, separator: String) -> String {
        var string: String = ""
        for (key, subJson) in data {
            let str = subJson.string
            if key == "0" && str != nil {
                string.appendContentsOf(str!)
            }
            else {
                if str != nil {
                    string.appendContentsOf(separator + str!)
                }
            }
        }
        return string
    }
    
}
