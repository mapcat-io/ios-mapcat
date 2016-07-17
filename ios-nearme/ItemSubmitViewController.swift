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
                    sectionAddItem += [TextRow("AddItem" + String(self.counter)){ row in
                        row.title = "Item"
                        row.placeholder = "Name"
                        }]
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
                    // add button to accessory view
                    let image = UIImage(named: "camera_icon") as UIImage?
                    let button   = UIButton(type: UIButtonType.Custom) as UIButton
                    button.frame = CGRectMake(0, 0, 34, 34)
                    button.setImage(image, forState: .Normal)
                    button.titleLabel!.text = option
                    button.titleLabel!.hidden = true;
                    button.addTarget(self, action: #selector(self.accessoryButtonDidTouch), forControlEvents: .TouchUpInside)
                    cell.accessoryView = button
            }
                <<< ImageRow("img-" + option){
                    $0.title = nil
                    $0.hidden = true
            }
        }
        
        
//        form +++ SelectableSection<ListCheckRow<String>, String>("Popular Items", selectionType: .MultipleSelection)
//        for option in uniqueOptions {
//            form.last! <<< ListCheckRow<String>(option){ listRow in
//                listRow.title = option
//                listRow.selectableValue = option
//                listRow.value = nil
//            }
//        }
    
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
        
        print(parameters["items"])
        
        Alamofire.request(.POST, "http://www.mapcat.io/api/prototype/post-items", parameters: parameters, encoding: .JSON)
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
    
    func accessoryButtonDidTouch(sender: UIButton!) {
        print("Camera icon tapped")
        let option = sender.titleLabel!.text!
//        let imgOption = "img-" + option
//        print(imgOption)
//        let row: ImageRow? = form.rowByTag("img-" + option)
//        
//        row!.hidden = false
//        
//        let value = row!.value
//        print(value)
//        self.showAlert(sender.titleLabel!.text!)
    }
    
    func showAlert(option: String) {
        let alertController = UIAlertController(title: "OnCellSelection", message: option, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
        
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
