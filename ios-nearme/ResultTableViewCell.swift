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
        
        // set data from server
        let title = Utilities.joinArrayWithSeparator(result["things"], separator: ", ")
        let address = result["locations"][0]["street"].string ?? nil
        let place = result["locations"][0]["name"].string ?? nil
        let description = result["description"].string ?? nil
        let geoLat = result["locations"][0]["lat"].double ?? 37.763299
        let geoLong = result["locations"][0]["long"].double ?? -122.419356
        
        // set location information
        let destination = CLLocation(latitude: geoLat, longitude: geoLong)
        let setLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let distanceBetween: CLLocationDistance = destination.distanceFromLocation(setLocation)
        
        // display in UI
        titleLabel.text = place
        addressLabel.text = address
        categoriesLabel.text = title.capitalizedString
        descriptionLabel.text = description
        distanceLabel.text = String(format: "%.1f mi", distanceBetween * 0.000621371)
        
    }

}
