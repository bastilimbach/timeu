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
        let navController = UINavigationController(rootViewController: homeVC)
        navController.navigationBar.prefersLargeTitles = true

//        homeVC.tabBarItem = ESTabBarItem(title: "Home", image: nil, selectedImage: nil, tag: 1)
        let contentView = ESTabBarItemContentView()
        contentView.backdropColor = .black
        contentView.iconColor = .red

        homeVC.tabBarItem = ESTabBarItem(contentView, title: "Test", image: UIImage(named: "testIcon")!, selectedImage: nil, tag: 1)

        let controllers = [homeVC]

        _ = controllers.map { $0.view.backgroundColor = .timeuGray }
        viewControllers = [navController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
