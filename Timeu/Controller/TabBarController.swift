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
        homeVC.tabBarItem = ESTabBarItem(title: "Home", image: nil, selectedImage: nil, tag: 1)

        let controllers = [homeVC]

        let _ = controllers.map { $0.view.backgroundColor = UIColor.timeuGray }
        viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
