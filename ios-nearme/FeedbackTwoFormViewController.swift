//
//  FeedbackTwoFormViewController.swift
//  ios-mapcat
//
//  Created by Jennifer Long on 8/28/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import Eureka

class FeedbackTwoFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ SelectableSection<ListCheckRow<String>, String>("What's up?", selectionType: .SingleSelection(enableDeselection: true))
        
        let feelings = ["I'm ...", "I'm annoyed", "I'm excited", "I'm disappointed"]
        for option in feelings {
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
        
        form +++ Section("What's up?")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = NSDate(timeIntervalSinceReferenceDate: 0)
        }
    }

}
