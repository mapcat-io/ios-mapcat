//
//  ResultTableViewCell.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/20/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func configureWithResult(result: JSON, currentLocation: CLLocationCoordinate2D) {
        
        let title = result["title"].string!
        let address = result["place"][0]["location"]["street1"].string ?? "address unknown"
        let place = result["place"][0]["title"].string ?? "Place unknown"
        let description = result["description"].string ?? "No description"
        let geoLat = result["place"][0]["location"]["geo"][1].double ?? 37.763299
        let geoLong = result["place"][0]["location"]["geo"][0].double ?? -122.419356
        
        let destination = CLLocation(latitude: geoLat, longitude: geoLong)
        let setLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        let distanceBetween: CLLocationDistance = destination.distanceFromLocation(setLocation)
        
        titleLabel.text = title
        addressLabel.text = place + ", " + address
        descriptionLabel.text = description
        distanceLabel.text = String(format: "%.1f mi away", distanceBetween * 0.000621371)
        
        
    }

}
