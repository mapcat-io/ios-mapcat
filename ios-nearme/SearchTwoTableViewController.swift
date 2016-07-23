//
//  SearchTwoTableViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Accounts
import Alamofire

class SearchTwoTableViewController: UITableViewController {
    
    let accounts = Accounts()
    
    var selectedCell: UITableViewCell?
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("SearchTwoTableViewController Loaded")
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTwoTableResultCell") as! SearchTwoTableViewCell!
        selectedCell = cell
        let result = results[indexPath.row]
        cell.configureWithResult(result)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("SearchDetailsSegue", sender: selectedCell)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchDetailsSegue" {
            let toView = segue.destinationViewController as! SearchThreeViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
//            toView.currentLocation = currentLocation
        }
    }


}
