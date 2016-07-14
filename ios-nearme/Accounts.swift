//
//  Accounts.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/9/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import Foundation
import KeychainAccess

public class Accounts {
    
    let keychain = Keychain()

    // set UUID for new devices
    func setDeviceId() {
        if ((keychain["deviceId"]) == nil) {
            keychain["deviceId"] = NSUUID().UUIDString // Set string
            let deviceId = keychain["deviceId"] // Get string
            print("Set new Id: " + deviceId!)
        }
        else {
            print("Id already set: " + keychain["deviceId"]!)
        }
    }
    
    // get deviceId
    func getDeviceId() -> String?? {
        let deviceId = try? keychain.get("deviceId")
        return deviceId
    }

}
