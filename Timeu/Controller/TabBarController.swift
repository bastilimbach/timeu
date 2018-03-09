//
//  TabBarController.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
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
        let dummyVC = TimesheetViewController(currentUser: user)
        let settingsVC = SettingsViewController(style: .grouped)

        homeVC.navigationItem.title = "TimesheetVCTitle".localized()
        homeVC.tabBarItem = ESTabBarItem(TabBarItemView(), title: nil, image: UIImage(named: "timesheetIcon"))

        dummyVC.tabBarItem = ESTabBarItem(TabBarAddItemView(), title: nil, image: UIImage(named: "addActivityIcon"))

        settingsVC.navigationItem.title = "SettingsVCTitle".localized()
        settingsVC.tabBarItem = ESTabBarItem(TabBarItemView(), title: nil, image: UIImage(named: "settingsIcon"))

        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.navigationBar.prefersLargeTitles = true

        let settingsNavigationController = UINavigationController(rootViewController: settingsVC)
        settingsNavigationController.navigationBar.prefersLargeTitles = true

        let _ = [homeVC, dummyVC, settingsVC].map { $0.view.backgroundColor = .timeuGray }

        shouldHijackHandler = { _, _, index in
            if index == 1 {
                return true
            }
            return false
        }

        didHijackHandler = { [weak self] _, _, _ in
            DispatchQueue.main.async {
                let alertView = UIAlertController.init(title: "Not implemented", message: "Sorry, this functionality isn't yet implemented.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self?.present(alertView, animated: true)
            }
        }

        viewControllers = [homeNavigationController, dummyVC, settingsNavigationController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
