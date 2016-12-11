//
//  SearchThreeFormViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/24/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import SwiftyJSON

class SearchThreeFormViewController: FormViewController {
    
    var items: JSON = []
    var name: String = ""
    
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
        
        Alamofire.request(.GET, "http://www.mapcat.io/api/v2/items-in-place", parameters: ["q" : self.name])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                let items = JSONObject["items"][0]["things"]
                self.form +++ Section("All Items at " + self.name)
                for item in items {
                    self.form.last! <<< TextRow(){ row in
                        row.title = item.1.string!.capitalizedString
                        row.disabled = true
                        row.textFieldPercentage = 0.0
                    }
                }
  
        }
        
    }
    

}
