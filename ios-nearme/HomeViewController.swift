//
//  HomeViewController.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/16/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: SpringImageView!
    @IBOutlet weak var searchTextField: DesignableTextField!
    
    

    @IBAction func searchButtonDidTouch(sender: AnyObject) {
        if self.searchTextField.text == "" {
            searchBar.animation = "shake"
            searchBar.animate()
        }
        else {
            performSegueWithIdentifier("SearchSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchSegue" {
            let toNav = segue.destinationViewController as! UINavigationController
            let toView = toNav.topViewController as! ResultsTableViewController
            toView.q = self.searchTextField.text!
        }
    }

}
