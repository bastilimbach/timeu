//
//  OSSDetailViewController.swift
//  Timeu
//
//  Created by Sebastian Limbach on 09.03.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SafariServices

class OSSDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Open Source Software"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Credits().oss.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        if Credits().oss[indexPath.row].website != nil {
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = Credits().oss[indexPath.row].name
        cell.detailTextLabel?.text = "by \(Credits().oss[indexPath.row].author)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let projectWebsite = Credits().oss[indexPath.row].website else { return }
        let safari = SFSafariViewController(url: projectWebsite)
        present(safari, animated: true)
    }

}
