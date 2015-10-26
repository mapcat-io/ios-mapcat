//
//  ResultsTableViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/20/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    var selectedCell: UITableViewCell?
    var results: JSON = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = q.capitalizedString
        Alamofire.request(.GET, "http://heroku-nearme.herokuapp.com/api/v1/things", parameters: ["q" : q])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.results = JSONObject["things"]
                for (key, _) in self.results {
                    let intKey: Int = Int(key)!
                    var thisItem: JSON = self.results[intKey]
                    let geoLat = thisItem["place"][0]["location"]["geo"][1].double ?? 37.763299
                    let geoLong = thisItem["place"][0]["location"]["geo"][0].double ?? -122.419356
                    let destination = CLLocation(latitude: geoLat, longitude: geoLong)
                    let setLocation = CLLocation(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
                    let distanceBetween: CLLocationDistance = destination.distanceFromLocation(setLocation)
                    thisItem["distance"].double =  distanceBetween
                    self.results[intKey] = thisItem
                }
                self.tableView.reloadData()
        }
    }

    @IBAction func HomeButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("HomeSegue", sender: self)
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell") as! ResultTableViewCell!
        selectedCell = cell
        let result = results[indexPath.row]
        cell.configureWithResult(result, currentLocation: currentLocation)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: selectedCell)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let toView = segue.destinationViewController as! DetailViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
            toView.currentLocation = currentLocation
            
        }
    }
    

}
