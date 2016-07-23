//
//  ProfileOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka
import Accounts
import Alamofire

class ProfileOneViewController: FormViewController {

    let accounts = Accounts()
    var profileStats: JSON = []
    var itemStats: JSON = []
    
    override func viewDidLoad() {
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as? AnyObject)!
        let deviceId: String = (accounts.getDeviceId() ?? "No Id Set")!
        super.viewDidLoad()
        
        form +++ Section("Account")
            <<< TextRow(){ row in
                row.title = deviceId
                row.disabled = true
        }
        
        // get rank
        Alamofire.request(.GET, "http://www.mapcat.io/api/v2/item-stats")
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.itemStats = JSONObject["items"]
                // get rank
                var rank: String = ""
                for (key, subJson) in self.itemStats {
                    if subJson["_id"].string == deviceId {
                        rank = key
                    }
                }
                // display in UI
                self.form +++ Section("Rank")
                    <<< TextRow(){ row in
                        row.title = rank != "" ? rank : "Unknown"
                        row.disabled = true
                    }
                // get stats
                Alamofire.request(.GET, "http://www.mapcat.io/api/v2/item-stats", parameters: ["t" : "profile", "u": sourceDeviceId])
                    .responseJSON { response in
                        let JSONObject = JSON(response.result.value!)
                        self.profileStats = JSONObject["items"][0]
                        // set data
                        let itemCount = String(self.profileStats["count"]) ?? "Unknown"
                        let places = self.profileStats["places"] ?? []
                        let placesCount = String(self.profileStats["places"].count) ?? "Unknown"
                        // display in UI
                        self.form +++ Section("Items Added")
                            <<< TextRow(){ row in
                                row.title = itemCount
                                row.disabled = true
                            }
                            +++ Section("Places Added To")
                            <<< TextRow(){ row in
                                row.title = placesCount
                                row.disabled = true
                            }
                            +++ Section("Places")
                        for place in places {
                            self.form.last! <<< TextRow(){ row in
                                row.title = place.1.string
                                row.disabled = true
                            }
                        }
                }
        }
        
    }
    
}