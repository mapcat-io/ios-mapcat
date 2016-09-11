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
import PagedArray



// Tweak these values and see how the user experience is affected
let PreloadMargin = 20 /// How many rows "in front" should be loaded
let PageSize = 10 /// Paging size
let TotalCount = 200 /// Number of rows in table view


class SearchTwoTableViewController: UITableViewController {
    
    let accounts = Accounts()
    
    var selectedCell: UITableViewCell?
    var results: [JSON] = []
    var q: String = ""
    var currentLocation: CLLocationCoordinate2D!
    
    var mapView: MKMapView!
    
    let cellIdentifier = "Cell"
    let operationQueue = NSOperationQueue()
    
    var pagedArray = PagedArray<String>(count: TotalCount, pageSize: PageSize)
    var shouldPreload = false
    
    var dataLoadingOperationArray = [Int: NSOperation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    private func configureCell(cell: UITableViewCell, data: String?) {
        cell.textLabel!.text = data ?? ""
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagedArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print(indexPath.row)
        
        loadDataIfNeededForRow(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTwoTableResultCell") as! SearchTwoTableViewCell!
        selectedCell = cell
        //let result = results[indexPath.row]
        //cell.configureWithResult(result)
        configureCell(cell, data: pagedArray[indexPath.row])
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("SearchDetailsSegue", sender: selectedCell)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchDetailsSegue" {
            let toView = segue.destinationViewController as! SearchThreeViewController
            toView.result = results[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    private func loadDataIfNeededForRow(row: Int) {
        
        let currentPage = pagedArray.pageNumberForIndex(row)
        
        //print(currentPage)
        if needsLoadDataForPage(currentPage) {
            loadDataForPage(currentPage)
        }
        
        let preloadIndex = row+PreloadMargin
        //print("preloadIndex" )
        //print(preloadIndex)
        
        if preloadIndex < pagedArray.endIndex && shouldPreload {
            let preloadPage = pagedArray.pageNumberForIndex(preloadIndex)
            if preloadPage > currentPage && needsLoadDataForPage(preloadPage) {
                loadDataForPage(preloadPage)
            }
        }
    }
    
    private func needsLoadDataForPage(page: Int) -> Bool {
        return pagedArray.pages[page] == nil && dataLoadingOperationArray[page] == nil
    }
    
    private func loadDataForPage(page: Int) {
        let indexes = pagedArray.indexes(page)
        
        // Create loading operation
        print(indexes)
        print(self.q)
        print(self.currentLocation)
        print(self.mapView)
        
        let operation = DataLoadingOperation(indexesToLoad: indexes,
                                             q:self.q,
                                             currentLocation:self.currentLocation,
                                             mapView: self.mapView)
        {
            [unowned self] indexes, data in
            print("sdasdas")
            print(data)
            
            
            // Set elements on paged array
            self.pagedArray.setElements(data, pageIndex: page)
            
            // Reload cells
            if let indexPathsToReload = self.visibleIndexPathsForIndexes(indexes) {
                self.tableView.reloadRowsAtIndexPaths(indexPathsToReload, withRowAnimation: .Automatic)
            }
            
            // Cleanup
            self.dataLoadingOperationArray[page] = nil
        }
        
        // Add operation to queue and save it
        operationQueue.addOperation(operation)
        dataLoadingOperationArray[page] = operation
    }
    
    private func visibleIndexPathsForIndexes(indexes: Range<Int>) -> [NSIndexPath]? {
        return tableView.indexPathsForVisibleRows?.filter { indexes.contains($0.row) }
    }
}


class DataLoadingOperation: NSBlockOperation {
    
    init(indexesToLoad: Range<Int>, q:String, currentLocation:CLLocationCoordinate2D,
         mapView:MKMapView,
         completion: (indexes: Range<Int>, data: [String]) -> Void) {
        
        super.init()
        
        var data: [String] = []
        
        print("Loading indexes: \(indexesToLoad)")
        
        
        addExecutionBlock {
            
            // Simulate loading
            // NSThread sleepForTimeInterval(DataLoadingOperationDuration)
            
            Alamofire.request(.GET, "http://localhost:3000/api/v2/items", parameters: ["q" : q, "t": "aggregate"])
                .responseJSON { response in
                    
                    var JSONObject = JSON(response.result.value!)
                    var results = JSONObject["items"].arrayValue
                    if JSONObject["items"].count > 0 {
                        let currentLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                        let rawResults: JSON = Utilities.populateDistanceBetween(JSONObject["items"], currentLocation: currentLocation)
                        results = rawResults.sort { $0.0.1["distance"].doubleValue < $0.1.1["distance"].doubleValue }.map { $0.1 }
                        //= add map pins to mapView
                        var counter: Int = 0
                        for item in results {
                            let lat = item["locations"][0]["lat"].double
                            let long = item["locations"][0]["long"].double
                            let pinLocation = CLLocationCoordinate2DMake(lat!, long!)
                            let title = item["_id"]["name"].string
                            data.append(title!)
                            print ("title", title!)
                            let dropPin = CustomAnnotation(coordinate: pinLocation, title: title!, id: String(counter))
                            mapView.addAnnotation(dropPin)
                            counter += 1
                        }
                        
                        //data =  results
                        
                        
                        
                    }
                    else {
                        //= no results
                       
                    }
            }
            
            
            
        }
        
        completionBlock = {
            print("all done loading")
            print(data)
            if (data.count == 0){
                data = indexesToLoad.map { "Content data \($0)" }
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                completion(indexes: indexesToLoad, data: data)
            }
        }
        
    }
}

