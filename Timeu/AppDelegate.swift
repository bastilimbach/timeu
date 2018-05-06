//
//  AppDelegate.swift
//  Timeu
//
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/).
//  All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import UIKit
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        resetStateForUITesting()
        UIApplication.shared.isStatusBarHidden = false
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let keychain = Keychain(service: Bundle.main.bundleIdentifier!)

        if let key = try? keychain.get("apiKey") {
            if let apiKey = key {
                if let currentUser = UserDefaults.standard.dictionary(forKey: "currentUser") {
                    guard let username = currentUser["username"] as? String,
                        let endpoint = currentUser["endpoint"] as? String,
                        let endpointURL = URL(string: endpoint) else { return true }
                    let user = User(
                        userName: username,
                        apiEndpoint: endpointURL,
                        apiKey: apiKey
                    )

                    window?.rootViewController = TabBarController(currentUser: user)
                    return true
                }
            }
        }

        window?.rootViewController = LoginViewController()
        return true
    }

    private func resetStateForUITesting() {
        if ProcessInfo.processInfo.arguments.contains("UI-Testing") {
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}
