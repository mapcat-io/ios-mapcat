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
                let feelings = ["I'm confused 🐱", "I'm disappointed 😿", "I'm annoyed 😾", "I'm surprised 🙀", "I'm excited 😸", "I'm ..."]
                for item in feelings {
                    row.options.append(item)
                    row.value = item
                }
        }
        
        form +++ Section()
            <<< TextAreaRow("note") {
                $0.placeholder = "Because .."
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 150)
            }

    }
    
    @IBAction func submitButtonDidTouch(_ sender: AnyObject) {
        var parameters: [String: AnyObject] = [:]
        
        let sourceDeviceId: AnyObject = (accounts.getDeviceId() as? AnyObject)!
        let valuesDictionary = form.values()
        
        parameters["feeling"] = valuesDictionary["feeling"] as? AnyObject
        parameters["note"] = valuesDictionary["note"] as? AnyObject
        parameters["deviceId"] = sourceDeviceId
        
        Alamofire.request("http://127.0.0.1:3911/api/v2/post-feedback", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let alertController = UIAlertController(title: "😻", message:
                        "Feedback successfully submitted!", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Thanks", style: UIAlertActionStyle.default, handler:  { action in self.performSegue(withIdentifier: "unwindToSearch", sender: self) }))
                    self.present(alertController, animated: true, completion: nil)
                case .failure(let error):
                    // display error alert
                    let alertController = UIAlertController(title: "😿", message:
                        "There was an error submitting your feedback.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
        }
        
        
    }
    
}
