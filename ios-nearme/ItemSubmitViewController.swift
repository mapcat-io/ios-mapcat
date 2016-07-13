//
//  TopThingsViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/4/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import Accounts
import Eureka
import SwiftyJSON

class ItemSubmitViewController: FormViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    let accounts = Accounts()
    
    var result: JSON!
    var topThings: JSON = []
    var options: [String] = []
    var counter: Int = 1
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = result["name"].string ?? ""
        // add top-things to options array
        for (key, subJson) in topThings {
            if let name = subJson["name"].string {
                options.append(name)
            }
        }
        
        // set view
        navTitle.title = title.capitalizedString
        
        // form
        var sectionAddItem = Section("Add Item")
        
        form +++ sectionAddItem
            // add new item button
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "New Item"
                }  .onCellSelection({ (cell, row) in
                    // add new item on cell select
                    sectionAddItem += [TextRow("AddItem" + String(self.counter)){ row in
                        row.title = "Item"
                        row.placeholder = "Name"
                        }]
                    self.counter += 1
                })
        
        +++ SelectableSection<ListCheckRow<String>, String>("Popular Items", selectionType: .MultipleSelection)
        let uniqueOptions = uniq(options)
        for option in uniqueOptions {
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
    
    }
    
    @IBAction func submitButtonDidTouch(sender: UIBarButtonItem) {

        // get all the values
        var parameters: [String: AnyObject] = [:]
        var items: [String: AnyObject] = [:]
        let valuesDictionary = form.values()
        for (key, value) in valuesDictionary {
            if value != nil {
                let temp : String! = value as? String
                items[key] = temp
            }
        }
        
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as? AnyObject)!
        parameters["source"] = ["name": "webView", "deviceId": sourceDeviceId]
        parameters["foursquare"] = result.object ?? "not set"
        parameters["items"] = items
        
        Alamofire.request(.POST, "http://localhost:3000/api/prototype/post-items", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success:
//                    print("Validation Successful")
                    self.performSegueWithIdentifier("SubmitItemsSegue", sender: self)
                case .Failure(let error):
//                    print(error)
                    // display error alert
                    let alertController = UIAlertController(title: "Error", message:
                        "There was an error submitting the items.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SubmitItemsSegue" {
            let toView = segue.destinationViewController as! PlacesTableViewController
            toView.currentLocation = currentLocation
            
        }
    }
    
    func uniq<S : SequenceType, T : Hashable where S.Generator.Element == T>(source: S) -> [T] {
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
