//
//  Accounts.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/9/16.
//  Copyright © 2016 Ryan Walton. All rights reserved.
//

import Foundation
import KeychainAccess

open class Accounts {
    
    let keychain = Keychain()

    // set UUID for new devices
    func setDeviceId() {
        if ((keychain["deviceId"]) == nil) {
            keychain["deviceId"] = UUID().uuidString // Set string.
        }
        else {
            // do nothing
        }
    }
    
    // get deviceId
    func getDeviceId() -> String?? {
        let deviceId = try? keychain.get("deviceId")
        return deviceId
    }

}
