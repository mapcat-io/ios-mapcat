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
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func configureWithResult(result: JSON, currentLocation: CLLocationCoordinate2D) {
        
        let title = result["Thing"].string!
        let address = result["Street"].string ?? nil
        let place = result["Place name"].string ?? nil
        let description = result["Description"].string ?? nil
        let geoLat = result["Latitude"].double ?? 37.763299
        let geoLong = result["Longitude"].double ?? -122.419356
        
        let destination = CLLocation(latitude: geoLat, longitude: geoLong)
        let setLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let distanceBetween: CLLocationDistance = destination.distanceFromLocation(setLocation)
        
        titleLabel.text = place
        addressLabel.text = address
        categoriesLabel.text = title.capitalizedString
        descriptionLabel.text = description
        distanceLabel.text = String(format: "%.1f mi", distanceBetween * 0.000621371)
        
    }

}
