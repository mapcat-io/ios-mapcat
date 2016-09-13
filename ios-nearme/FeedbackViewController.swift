//
//  FeedbackViewController.swift
//  ios-mapcat
//
//  Created by Imran on 2016-09-13.
//  Copyright © 2016 Mapcat.io . All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire
import Accounts
import Eureka
import SwiftyJSON

class FeedbackViewController: UIViewController {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!

override func viewDidLoad() {
    super.viewDidLoad()
  /*
    
    textView.layer.cornerRadius = 5
    textView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
    textView.layer.borderWidth = 0.5
    textView.clipsToBounds = true
    
    textView.alpha = 1
    sendButton.alpha = 1
    labelTitle.alpha = 1*/
    
 
    
}

    
    @IBAction func sendButtonPressed(sender: AnyObject) {
        
        print("What is this? " + textView.text)
    }


}