//
//  AddOneTableViewController.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/22/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class AddOneTableViewController: UITableViewController {
    
    let locationManager = CLLocationManager()
    
    var lat: Double = 0
    var long: Double = 0
    var selectedCell: UITableViewCell?
    var results: JSON = []
    var topThings: JSON = []
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(AddOneTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        
        lat = (locationManager.location?.coordinate.latitude)!
        long = (locationManager.location?.coordinate.longitude)!
        
        // get top things for subsequent view
        Alamofire.request(.GET, "http://www.mapcat.io/api/v2/top-things")
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.topThings = JSONObject["items"]
        }
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get places results to populate table
        Alamofire.request(.GET, "http://www.mapcat.io/api/v2/places", parameters: ["lat" : lat, "long": long])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.results = JSONObject["venues"]
                self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOneTableResultCell") as! AddOneTableViewCell!
        selectedCell = cell
        let result = results[indexPath.row]
        cell?.configureWithResult(result)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddSubmitSegue", sender: selectedCell)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSubmitSegue" {
            let toView = segue.destination as! AddTwoViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
            toView.topThings = self.topThings
            
        }
    }

    @IBAction func unwindToPlaces(_ segue: UIStoryboardSegue) {}
    
    func refresh(_ sender:AnyObject) {
        // Updating data on pull to refresh
        lat = (locationManager.location?.coordinate.latitude)!
        long = (locationManager.location?.coordinate.longitude)!
        Alamofire.request(.GET, "http://www.mapcat.io/api/v2/places", parameters: ["lat" : lat, "long": long])
            .responseJSON { response in
                let JSONObject = JSON(response.result.value!)
                self.results = JSONObject["venues"]
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
        }
        
    }

}
