//
//  ResultsTableViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/20/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import Alamofire

class ResultsTableViewController: UITableViewController {
    
    var selectedCell: UITableViewCell?
    var results: JSON = []
    var q: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "http://heroku-nearme.herokuapp.com/api/v1/things", parameters: ["q" : q])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                //now you can use the JSONObject as intended
                //print(JSONObject["things"])
                self.results = JSONObject["things"]
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
        cell.configureWithResult(result)
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
            
        }
    }
    

}
