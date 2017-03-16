//
//  AddTwoViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Jen Long. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import Accounts
import Eureka
import SwiftyJSON
import Flurry_iOS_SDK

class AddTwoViewController: FormViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    let accounts = Accounts()
    
    var result: JSON!
    var topThings: JSON = []
    var options: [String] = []
    var counter: Int = 1
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Flurry.logEvent("AddtoMapItems_View", timed: true)
        
        let title = result["name"].string ?? ""
        // add top-things to options array
        for (_, subJson) in topThings {
            if let name = subJson["name"].string {
                options.append(name)
            }
        }
        let popularRows = uniq(options)
        
        // set view
        navTitle.title = title.capitalized
        
        // form
        var sectionAddItem = Section("Add Item")
        
        form +++ sectionAddItem
            // add new item button
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "New Item"
                }  .onCellSelection({ (cell, row) in
                    // add new item on cell select
                    sectionAddItem.insert(TextRow("AddItem" + String(self.counter)){ row in
                        row.placeholder = "Name"
                        }, at: 1)
                    self.counter += 1
                })
        
        form +++ SelectableSection<ListCheckRow<String>>("Popular Items", selectionType: .multipleSelection)
        for option in popularRows {
            form.last! <<< ListCheckRow<String>(option){ row in
                row.title = option
                row.selectableValue = option
                row.value = nil
            }
        }
        
    }
    
    @IBAction func submitButtonDidTouch(_ sender: AnyObject) {
        // get all the values
        var parameters: [String: AnyObject] = [:]
        var items: [String: AnyObject] = [:]
        let valuesDictionary = form.values()
        for (key, value) in valuesDictionary {
            if value != nil {
                let temp : AnyObject! = value as AnyObject
                items[key] = temp
            }
        }

<<<<<<< HEAD
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as? AnyObject)!
        parameters["source"] = ["name": "webView", "deviceId": sourceDeviceId]
        parameters["foursquare"] = result.object ?? "not set" as AnyObject?
        parameters["items"] = items as AnyObject?
=======
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as AnyObject)
        parameters["source"] = ["name": "webView", "deviceId": sourceDeviceId] as AnyObject
        parameters["foursquare"] = result.object as AnyObject?? ?? "not set" as AnyObject?
        parameters["items"] = items as AnyObject?
        parameters["token"] = "N2ax2YzrL5MkY0WAIpKEWv2EGA8D4eqp" as AnyObject?
        
        Flurry.logEvent("Items_Submit", withParameters: ["location": result["name"], "lat": result["location"]["lat"], "long": result["location"]["lng"], "itemsCount": parameters["items"]?.count as Any])
>>>>>>> e4d4c712428b856818be62af2f255797a4053edd

        Alamofire.request("http://api.mapcat.io:3911/api/v2/post-items", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let alertController = UIAlertController(title: "😻", message:
                        "Items successfully submitted!", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Thanks", style: UIAlertActionStyle.default, handler:  { action in self.performSegue(withIdentifier: "unwindToPlaces", sender: self) }))
                    self.present(alertController, animated: true, completion: nil)
                case .failure(_):
                    // display error alert
                    let alertController = UIAlertController(title: "😿", message:
                        "There was an error submitting the items.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
        }

    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "SubmitItemsSegue" {
//            let toView = segue.destinationViewController as! PlacesTableViewController
//            
//        }
//    }
    
    func uniq<S : Sequence, T : Hashable>(_ source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
}

