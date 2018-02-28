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
        let settingsVC = TimesheetViewController(currentUser: user)

        homeVC.navigationItem.title = NSLocalizedString("TimesheetVCTitle", comment: "")
        homeVC.tabBarItem = ESTabBarItem(TabBarItemView(), title: nil, image: UIImage(named: "timesheetIcon"))
        dummyVC.tabBarItem = ESTabBarItem(TabBarAddItemView(), title: nil, image: UIImage(named: "addActivityIcon"))
        settingsVC.tabBarItem = ESTabBarItem(TabBarItemView(), title: nil, image: UIImage(named: "settingsIcon"))

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
