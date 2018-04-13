//
//  OSSDetailViewController.swift
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

class OSSDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ossDetail.navigationTitle".localized()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Credits.oss.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        if Credits.oss[indexPath.row].website != nil {
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = Credits.oss[indexPath.row].name
        cell.detailTextLabel?.text = "\("graphicsDetail.detailText.seperator".localized()) \(Credits.oss[indexPath.row].author)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let projectWebsite = Credits.oss[indexPath.row].website else { return }
        let safari = SFSafariViewController(url: projectWebsite)
        present(safari, animated: true)
    }

}
