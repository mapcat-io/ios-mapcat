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
        performSegueWithIdentifier("SearchSegue", sender: self)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
