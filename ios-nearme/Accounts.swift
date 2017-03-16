//
//  Accounts.swift
//  ios-mapcat
//
//  Created by Ryan Walton on 7/9/16.
//  Copyright © 2016 Mapcat. All rights reserved.
//

import Foundation
import KeychainAccess
import Flurry_iOS_SDK

open class Accounts {
    
    let keychain = Keychain()

    // set UUID for new devices
    func setDeviceId() {
        if ((keychain["deviceId"]) == nil) {
<<<<<<< HEAD
            keychain["deviceId"] = UUID().UUIDString // Set string.
=======
            keychain["deviceId"] = UUID().uuidString // Set string.
>>>>>>> e4d4c712428b856818be62af2f255797a4053edd
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
