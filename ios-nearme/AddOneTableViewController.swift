//
//  AddOneTableViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AddOneTableViewController: UITableViewController {
    
    let locationManager = CLLocationManager()
    
    var selectedCell: UITableViewCell?
    var results: JSON = []
    var topThings: JSON = []
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        
        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/places", parameters: ["lat" : lat!, "long": long!])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.results = JSONObject["venues"]
                self.tableView.reloadData()
        }
        // get top things for subsequent view
        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/top-things")
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.topThings = JSONObject["items"]
        }
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddOneTableResultCell") as! AddOneTableViewCell!
        selectedCell = cell
        let result = results[indexPath.row]
        cell.configureWithResult(result)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("AddSubmitSegue", sender: selectedCell)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddSubmitSegue" {
            let toView = segue.destinationViewController as! AddTwoViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
            toView.topThings = self.topThings
            
        }
    }

    @IBAction func unwindToPlaces(segue: UIStoryboardSegue) {}


}
