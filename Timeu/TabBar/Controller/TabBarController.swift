//
//  TabBarController.swift
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
import ESTabBarController

class TabBarController: ESTabBarController {
    private let user: User

    init(currentUser: User) {
        user = currentUser
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = TimesheetViewController(currentUser: user)
        let creationVC = RecordCreationController(currentUser: user)
        let settingsVC = SettingsViewController(style: .grouped)

        homeVC.navigationItem.title = "timesheet.navigationTitle".localized()
        homeVC.tabBarItem = ESTabBarItem(TabBarItemView(), title: nil, image: UIImage(named: "timesheetIcon"))

        creationVC.tabBarItem = ESTabBarItem(TabBarAddItemView(), title: nil, image: UIImage(named: "addActivityIcon"))

        settingsVC.navigationItem.title = "settings.navigationTitle".localized()
        settingsVC.tabBarItem = ESTabBarItem(TabBarItemView(), title: nil, image: UIImage(named: "settingsIcon"))

        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.navigationBar.prefersLargeTitles = true

        let settingsNavigationController = UINavigationController(rootViewController: settingsVC)
        settingsNavigationController.navigationBar.prefersLargeTitles = true

        _ = [homeVC, creationVC, settingsVC].map { $0.view.backgroundColor = .timeuGray }

        shouldHijackHandler = { _, _, index in
            return index == 1
        }

        didHijackHandler = { [weak self] _, _, _ in
//            DispatchQueue.main.async {
//                let alertView = UIAlertController.init(
//                    title: "addTimesheetRecord.comingSoon.title".localized(),
//                    message: "addTimesheetRecord.comingSoon.description".localized(),
//                    preferredStyle: .alert
//                )
//                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
//                self?.present(alertView, animated: true)
//            }
            self?.present(UINavigationController(rootViewController: creationVC), animated: true)
        }

        viewControllers = [homeNavigationController, creationVC, settingsNavigationController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
