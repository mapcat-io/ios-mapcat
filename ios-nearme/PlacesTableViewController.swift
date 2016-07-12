//
//  PlacesTableViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/4/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class PlacesTableViewController: UITableViewController {
    
    var selectedCell: UITableViewCell?
    var results: JSON = []
    var topThings: JSON = []
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentLocation = CLLocation(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
        
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude

        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/places", parameters: ["lat" : lat, "long": long])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.results = JSONObject["venues"]
                self.tableView.reloadData()
        }
        // get top things for subsequent view
        Alamofire.request(.GET, "http://localhost:3000/api/prototype/top-things")
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.topThings = JSONObject["items"]
        }
        // remove empty cells if needed
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func HomeButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("HomeSegue", sender: self)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as! PlaceTableViewCell!
        selectedCell = cell
        let result = results[indexPath.row]
        cell.configureWithResult(result)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("TopThingsSegue", sender: selectedCell)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TopThingsSegue" {
            let toView = segue.destinationViewController as! ItemSubmitViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
            toView.currentLocation = currentLocation
            toView.topThings = topThings
            
        }
    }


}
