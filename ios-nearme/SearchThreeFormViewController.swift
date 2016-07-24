//
//  SearchThreeFormViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/24/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka

class SearchThreeFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            +++ Section("Places Added To")
            <<< TextRow(){ row in
                row.title = placesCount
                row.disabled = true
        }
        
    }
    

}
