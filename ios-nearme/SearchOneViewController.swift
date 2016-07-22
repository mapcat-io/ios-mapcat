//
//  SearchOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit

class SearchOneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("SearchResultsSegue", sender: self)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResultsSegue" {
//            let toView = segue.destinationViewController as! SearchResultsViewController
//            toView.q = self.searchTextField.text!
//            toView.currentLocation = locationManager.location!.coordinate
        }
    }
    

}
