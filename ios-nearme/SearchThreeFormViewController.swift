//
//  SearchThreeFormViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/24/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka

class SearchThreeFormViewController: FormViewController {
    
    var items: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

            form +++ Section("Items Matching Your Search")
            for item in self.items {
                self.form.last! <<< TextRow() {
                    $0.title = String(item.1).capitalizedString
                    $0.disabled = true
                    $0.textFieldPercentage = 0.0
                }
            }
        
    }
    

}
