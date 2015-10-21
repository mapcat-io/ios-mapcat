//
//  ResultsTableViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/20/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    @IBAction func HomeButtonDidTouch(sender: AnyObject) {
        
        performSegueWithIdentifier("HomeSegue", sender: self)
        
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell") as UITableViewCell!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

}
