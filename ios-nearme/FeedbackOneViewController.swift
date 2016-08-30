//
//  FeedbackOneViewController.swift
//  ios-mapcat
//
//  Created by Jennifer Long on 8/28/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit

class FeedbackOneViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var emotionPickerView: UIPickerView!
    @IBOutlet weak var becauseTextView: UITextView!
    
    var emotionDataSource = ["I'm ...", "I'm annoyed", "I'm surprised", "I'm disappointed", "I'm happy", "I just wanna tell you" ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emotionPickerView.dataSource = self;
        self.emotionPickerView.delegate = self;
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emotionDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return emotionDataSource[row]
    }

    

}
