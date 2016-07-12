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
            // initial text row
//            <<< TextRow("addItem0"){ row in
//                row.title = "Item"
//                row.placeholder = "Name"
//            }
        
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
        
        print("submitButtonDidTouch")
        
        // get all the values
        let valuesDictionary = form.values()
        print(valuesDictionary)
        
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

//class TopThingsViewController: UIViewController {
//    
//    @IBOutlet weak var navTitle: UINavigationItem!
//    
//    let accounts = Accounts()
//    
//    var result: JSON!
//    var currentLocation: CLLocationCoordinate2D!
//
//    override func viewDidLoad() {
//        
//        let title = result["name"].string ?? ""
//        let id = result["id"].string ?? ""
//        let name = result["name"].string ?? ""
//        let lat = String(result["location"]["lat"]) ?? ""
//        let long = String(result["location"]["lng"]) ?? ""
//        
//        let source = "webView"
//        let deviceId = accounts.getDeviceId()
//        let address = result["location"]["address"].string ?? ""
//        let categoryName = result["categories"][0]["name"].string ?? ""
//        let city = result["location"]["city"].string ?? ""
//        let country = result["location"]["country"].string ?? ""
//        let phone = result["contact"]["phone"].string ?? ""
//        let postalCode = result["location"]["postalCode"].string ?? ""
//        let state = result["location"]["state"].string ?? ""
//        let twitterId = result["contact"]["twitter"].string ?? ""
//        let placeUrl = result["url"].string ?? ""
//        
//        let nameParam = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        let addressParam = address.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        let categoryNameParam = categoryName.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        let cityParam = city.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        let countryParam = country.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        let placeUrlParam = placeUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//        
//        let baseUrl = "http://localhost:3000/ios/place/" + id + "/?name=" + nameParam!
//        let paramOne = "&id=" + id + "&url=" + placeUrlParam!
//        let paramTwo = "&lat=" + lat + "&long=" + long + "&source=" + source
//        let paramThree =  "&categoryName=" + categoryNameParam! + "&city=" + cityParam!
//        let paramFour = "&phone=" + phone + "&postalCode=" + postalCode + "&state=" + state + "&twitterId=" + twitterId
//        let paramFive = "&address=" + addressParam! + "&country=" + countryParam!
//        let paramSix = "&deviceId=" + deviceId!!
//        let postUrl = baseUrl + paramOne + paramTwo + paramThree + paramFour + paramFive + paramSix
//        
//        let url = NSURL (string: postUrl);
//        
//        let requestObj = NSURLRequest(URL: url!);
//        
//        
//        // set view
//        navTitle.title = title.capitalizedString
//        topThingsWebView.loadRequest(requestObj);
//        
//
//    }
//
//}
