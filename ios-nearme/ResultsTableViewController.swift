//
//  ResultsTableViewController.swift
//  ios-nearme
//
//  Created by Jen Long on 6/1/16.
//  Copyright © 2016 Mapcat.io. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    var selectedCell: UITableViewCell?
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        q = q.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        titleLabel.title = q.capitalizedString
        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/things", parameters: ["q" : q])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                let currentLocation = CLLocation(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
                let rawResults: JSON = Utilities.populateDistanceBetween(JSONObject["things"], currentLocation: currentLocation)
                self.results = rawResults.sort { $0.0.1["distance"].doubleValue < $0.1.1["distance"].doubleValue }.map { $0.1 }
                self.tableView.reloadData()
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
