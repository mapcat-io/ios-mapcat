//
//  AppDelegate.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/15/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import UIKit
import CoreData
import Flurry_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Flurry analytics
        Flurry.startSession("QX7RWJ5Z4J3TWQJPVVSS")
        
        //= Main Tab Controller
        let mainTabController = self.window!.rootViewController as! UITabBarController
        let mainTabBar = mainTabController.tabBar
        let searchTab: UITabBarItem = mainTabBar.items![0] as UITabBarItem
        let addTab: UITabBarItem = mainTabBar.items![1] as UITabBarItem
        let feedbackTab: UITabBarItem = mainTabBar.items![2] as UITabBarItem
        let profileTab: UITabBarItem = mainTabBar.items![3] as UITabBarItem
        
        mainTabBar.backgroundImage = UIImage(named:"background-tabbar")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), resizingMode: .stretch)
        
        mainTabController.tabBar.barTintColor = UIColor(red:0.92, green:0.36, blue:0.56, alpha:0.7)
        mainTabController.tabBar.isTranslucent = true
        mainTabController.tabBar.tintColor = UIColor(red:0.92, green:0.36, blue:0.56, alpha:0.7)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.39, green:0.03, blue:0.16, alpha:1.0)], for:UIControlState())
        
        searchTab.selectedImage = UIImage(named:"search-icon-selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        searchTab.image = UIImage(named:"search-icon-unselected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        addTab.selectedImage = UIImage(named:"add-icon-selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        addTab.image = UIImage(named:"add-icon-unselected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        profileTab.selectedImage = UIImage(named:"profile-icon-selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        profileTab.image = UIImage(named:"profile-icon-unselected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        feedbackTab.selectedImage = UIImage(named:"feedback-icon-selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        feedbackTab.image = UIImage(named:"feedback-icon-unselected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
<<<<<<< HEAD
=======
        
        Flurry.logAllPageViews(forTarget: mainTabController)
>>>>>>> e4d4c712428b856818be62af2f255797a4053edd
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "ryang24.ios_nearme" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "ios_nearme", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

