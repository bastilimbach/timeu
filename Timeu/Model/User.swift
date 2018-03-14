//
//  User.swift
//  Timeu
//
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/).
//  All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation
import KeychainAccess

struct User {
    let userName: String
    let apiEndpoint: URL
    var apiKey: String? {
        get {
            let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
            if let key = try? keychain.get("apiKey") ?? nil {
                return key
            } else {
                return nil
            }
        }
        set {
            guard let key = newValue else { return }
            try? Keychain(service: Bundle.main.bundleIdentifier!).set(key, key: "apiKey")
        }
    }

    init(userName: String, apiEndpoint: URL, apiKey: String?) {
        self.userName = userName
        self.apiEndpoint = apiEndpoint
        self.apiKey = apiKey
    }
}
