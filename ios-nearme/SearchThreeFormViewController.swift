//
//  SearchThreeFormViewController.swift
//  ios-mapcat
//
//  Created by Jen Long on 7/24/16.
//  Copyright © 2016 Mapcat. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import SwiftyJSON

class SearchThreeFormViewController: FormViewController {
    
    var items: JSON = []
    var name: String = ""
    var lochash: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Items Matching Your Search")
        for item in self.items {
            self.form.last! <<< TextRow() {
                $0.title = String(describing: item.1).capitalized
                $0.disabled = true
                $0.textFieldPercentage = 0.0
            }
        }
        
        Alamofire.request("http://api.mapcat.io:3911/api/v2.6/items-in-place", parameters: ["lochash" : self.lochash, "token": "N2ax2YzrL5MkY0WAIpKEWv2EGA8D4eqp"])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                let items = JSONObject["items"][0]["things"]
                self.form +++ Section("All Items at " + self.name)
                for item in items {
                    self.form.last! <<< TextRow(){ row in
                        row.title = item.1.string!.capitalized
                        row.disabled = true
                        row.textFieldPercentage = 0.0
                    }
                }
  
        }
        
    }
    

}
