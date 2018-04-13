//
//  GraphicsDetailViewController.swift
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
import SafariServices

class GraphicsDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "graphicsDetail.navigationTitle".localized()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Credits.graphics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        if Credits.graphics[indexPath.row].website != nil {
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = Credits.graphics[indexPath.row].name
        cell.detailTextLabel?.text = "\("graphicsDetail.detailText.seperator".localized()) \(Credits.graphics[indexPath.row].author)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let projectWebsite = Credits.graphics[indexPath.row].website else { return }
        let safari = SFSafariViewController(url: projectWebsite)
        present(safari, animated: true)
    }

}

