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

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeVC()
        let dummyVC = HomeVC()
        let settingsVC = HomeVC()

        homeVC.title = NSLocalizedString("HomeVCTitle", comment: "")
        homeVC.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "Home", image: UIImage(named: "testIcon"))
        dummyVC.tabBarItem = ESTabBarItem(TabBarAddItemView(), title: nil, image: UIImage(named: "addActivityIcon"))
        settingsVC.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "Settings", image: UIImage(named: "testIcon"))

        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.navigationBar.prefersLargeTitles = true

        let _ = [homeVC, dummyVC, settingsVC].map { $0.view.backgroundColor = .timeuGray }

        viewControllers = [homeNavigationController, dummyVC, settingsVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
