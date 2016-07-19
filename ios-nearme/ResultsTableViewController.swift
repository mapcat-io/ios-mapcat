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
    
    let accounts = Accounts()
    
    var selectedCell: UITableViewCell?
    var results: [JSON] = []
//    var venuePhotos: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the results
        let u: String = (accounts.getDeviceId() ?? "")!
        q = q.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        titleLabel.title = q.capitalizedString
        Alamofire.request(.GET, "http://www.mapcat.io/api/prototype/items", parameters: ["q" : q, "t": "aggregate", u: u])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                if JSONObject["items"].count > 0 {
                    let currentLocation = CLLocation(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
                    let rawResults: JSON = Utilities.populateDistanceBetween(JSONObject["items"], currentLocation: currentLocation)
                    self.results = rawResults.sort { $0.0.1["distance"].doubleValue < $0.1.1["distance"].doubleValue }.map { $0.1 } // refere to Utilities.populateDistanceBetween() for where location information is retrieved from
                    self.tableView.reloadData()
                }
                else {
//                    self.tableView.reloadData()
                    let alertController = UIAlertController(title: "😿", message:
                        "There are no results.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:  { action in self.performSegueWithIdentifier("HomeSegue", sender: self) }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
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
//        var venuePhotos: JSON = []
//        let venueId = results[self.tableView.indexPathForSelectedRow!.row]["locations"][0]["foursquareId"].string
//        print(venueId!)
//        let URL = NSURL(string: "http://localhost:3000/api/prototype/venue-photos")!
//        var request = NSMutableURLRequest(URL: URL)
//        let parameters = ["venueId" : venueId!]
//        let encoding = Alamofire.ParameterEncoding.URL
//        (request, _) = encoding.encode(request, parameters: parameters)
//        if (venueId != nil) {
//            Alamofire.request(.GET, request, encoding: .JSON)
//                .responseJSON { response in
//                    switch response.result {
//                    case .Success:
//                        print("success")
//                        venuePhotos = JSON(response.result.value!)
//                    case .Failure(let error):
//                        // display error alert
//                        print("Error Bra")
//                        print(error)
//                    }
//            }
//        }
        if segue.identifier == "DetailSegue" {
            let toView = segue.destinationViewController as! DetailViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
            toView.currentLocation = currentLocation
//            toView.venuePhotos = venuePhotos
        }
    }

}
