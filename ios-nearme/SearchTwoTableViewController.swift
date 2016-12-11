//
//  SearchTwoTableViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Accounts
import Alamofire
import SwiftyJSON

class SearchTwoTableViewController: UITableViewController {
    
    let accounts = Accounts()
    
    var selectedCell: UITableViewCell?
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTwoTableResultCell") as! SearchTwoTableViewCell!
        selectedCell = cell
        let result = results[indexPath.row]
        cell?.configureWithResult(result)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SearchDetailsSegue", sender: selectedCell)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchDetailsSegue" {
            let toView = segue.destination as! SearchThreeViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
        }
    }


}
