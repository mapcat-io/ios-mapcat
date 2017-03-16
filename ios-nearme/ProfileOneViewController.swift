//
//  ProfileOneViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Mapcat. All rights reserved.
//

import UIKit
import Eureka
import Accounts
import SwiftyJSON
import Flurry_iOS_SDK
import Alamofire

class ProfileOneViewController: FormViewController {
    
    let accounts = Accounts()
    var profileStats: JSON = []
    var itemStats: JSON = []
    
    override func viewDidLoad() {
        
        Flurry.logEvent("Profile_View", timed: true)
        
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as AnyObject)
        let deviceId: String = (accounts.getDeviceId() ?? "No Id Set")!
        print("herro")
        print(sourceDeviceId)
        print(deviceId)
        super.viewDidLoad()
        // get rank
        Alamofire.request("http://api.mapcat.io:3911/api/v2/item-stats", parameters: ["token": "N2ax2YzrL5MkY0WAIpKEWv2EGA8D4eqp"])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.itemStats = JSONObject["items"]
                // get rank
                var rank: String = ""
                for (key, subJson) in self.itemStats {
                    if subJson["_id"].string == deviceId {
                        rank = String(Int(key)! + 1)
                    }
                }
                // display in UI
                self.form +++ Section("Rank")
                    <<< TextRow(){ row in
                        row.title = rank != "" ? rank : "Add items to start ranking"
                        row.disabled = true
                        row.textFieldPercentage = 0.0
                    }
                // get stats
                Alamofire.request("http://api.mapcat.io:3911/api/v2/item-stats", parameters: ["t" : "profile", "u": sourceDeviceId, "token": "N2ax2YzrL5MkY0WAIpKEWv2EGA8D4eqp"])
                    .responseJSON { response in
                        let JSONObject = JSON(response.result.value!)
                        self.profileStats = JSONObject["items"][0]
                        // set data
                        var itemCount = String(describing: self.profileStats["count"])
                        if itemCount == "null" {
                            itemCount = "0"
                        }
                        
                        let places = self.profileStats["places"] 
                        let placesCount = String(self.profileStats["places"].count) 
                        // display in UI
                        self.form +++ Section("Items Added")
                            <<< TextRow(){ row in
                                row.title = itemCount
                                row.disabled = true
                                row.textFieldPercentage = 0.0
                            }
                            +++ Section("Places Added To")
                            <<< TextRow(){ row in
                                row.title = placesCount
                                row.disabled = true
                                row.textFieldPercentage = 0.0
                            }
                        if places.isEmpty {
                            self.form +++ Section("Places")
                                self.form.last! <<< TextRow(){ row in
                                    row.title = "No places added to"
                                    row.disabled = true
                                    row.textFieldPercentage = 0.0
                            }
                        }
                        else {
                            self.form +++ Section("Places")
                            for place in places {
                                self.form.last! <<< TextRow(){ row in
                                    row.title = place.1.string
                                    row.disabled = true
                                    row.textFieldPercentage = 0.0
                                }
                            }
                        }
                }
        }
        
    }
    
}
