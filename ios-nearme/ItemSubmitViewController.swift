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
        let uniqueOptions = uniq(options)
        
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
                    sectionAddItem.insert(TextRow("AddItem" + String(self.counter)){ row in
                        row.placeholder = "Name"
                        }, atIndex: 1)
                    self.counter += 1
                })
        
        let popularRows = uniq(options)
        
        form +++ SelectableSection<CustomRow<String>, String>("Popular Items", selectionType: .MultipleSelection)
        for option in popularRows {
            form.last! <<< CustomRow<String>(option){ row in
                row.title = option
                row.selectableValue = option
                row.value = nil
                }.cellSetup { cell, _ in
                    cell.trueImage = UIImage(named: "check_mark")!
                    cell.falseImage = UIImage(named: "check_mark_nil")!
                    cell.accessoryView?.frame = CGRectMake(0, 0, 34, 34)
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
                let temp : AnyObject! = value as? AnyObject
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
                    let alertController = UIAlertController(title: "😻", message:
                        "Items successfully submitted!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Thanks", style: UIAlertActionStyle.Default, handler:  { action in self.performSegueWithIdentifier("SubmitItemsSegue", sender: self) }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                case .Failure(let error):
                    // display error alert
                    let alertController = UIAlertController(title: "😿", message:
                        "There was an error submitting the items.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default,handler: nil))
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
