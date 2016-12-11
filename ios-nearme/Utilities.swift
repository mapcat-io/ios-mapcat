//
//  Utilities.swift
//  ios-nearme
//
//  Created by Jen Long on 6/1/16.
//  Copyright © 2016 Mapcat.io. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

open class Utilities  {
    
    public class func populateDistanceBetween(_ results: JSON, currentLocation: CLLocation) -> JSON {
        var results = results
        for (key, _) in results {
            let intKey: Int = Int(key)!
            var thisItem: JSON = results[intKey]
            let geoLat = thisItem["locations"][0][1].double ?? 37.763299
            let geoLong = thisItem["locations"][0][0].double ?? -122.419356
            let destination = CLLocation(latitude: geoLat, longitude: geoLong)
            let distanceBetween: CLLocationDistance = destination.distance(from: currentLocation)
            thisItem["distance"].double =  distanceBetween
            results[intKey] = thisItem
        }
        return results
    }
    

    open class func getDataFromUrl(_ url:URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: NSError? ) -> Void)) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            completion(data, response, error)
            }) .resume()
    }
    
    // return string from JSONSwifty Array object, with seperator
    open class func joinArrayWithSeparator(_ data: JSON, separator: String) -> String {
        var string: String = ""
        for (key, subJson) in data {
            let str = subJson.string
            if key == "0" && str != nil {
                string.append(str!)
            }
            else {
                if str != nil {
                    string.append(separator + str!)
                }
            }
        }
        return string
    }
    
}
