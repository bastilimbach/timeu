//
//  User.swift
//  Timeu
//
//  Created by Sebastian Limbach on 03.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
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
