//
//  FeedbackOneViewController.swift
//  ios-mapcat
//
//  Created by Jennifer Long on 8/28/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import Accounts

class FeedbackOneViewController: FormViewController {
    
    let accounts = Accounts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("What's up?")
            <<< PickerRow<String>("feeling") { (row : PickerRow<String>) -> Void in
                let feelings = ["I'm ...", "I'm annoyed", "I'm excited", "I'm disappointed"]
                for item in feelings {
                    row.options.append(item)
                    row.value = item
                }
        }
        
        form +++ Section()
            <<< TextAreaRow("note") {
                $0.placeholder = "Because .."
                $0.textAreaHeight = .Dynamic(initialTextViewHeight: 150)
            }

    }
    
    @IBAction func submitButtonDidTouch(sender: AnyObject) {
        var parameters: [String: AnyObject] = [:]
        
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as? AnyObject)!
        let valuesDictionary = form.values()
        
        parameters["feeling"] = valuesDictionary["feeling"] as? AnyObject
        parameters["note"] = valuesDictionary["note"] as? AnyObject
        parameters["deviceId"] = sourceDeviceId
        
        Alamofire.request(.POST, "http://www.mapcat.io/api/v2/post-feedback", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let alertController = UIAlertController(title: "😻", message:
                        "Feedback successfully submitted!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Thanks", style: UIAlertActionStyle.Default, handler:  { action in self.performSegueWithIdentifier("unwindToSearch", sender: self) }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                case .Failure(let error):
                    // display error alert
                    let alertController = UIAlertController(title: "😿", message:
                        "There was an error submitting your feedback.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }
        
        
    }
    
}
