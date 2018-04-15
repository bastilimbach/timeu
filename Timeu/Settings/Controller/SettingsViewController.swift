//
//  SettingsViewController.swift
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
import KeychainAccess

class SettingsViewController: UITableViewController {

    private let openSourceCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "settings.tableView.cell.openSource".localized()
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let graphicCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "settings.tableView.cell.graphics".localized()
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let contributorsCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "settings.tableView.cell.contributors".localized()
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let sourceCodeCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "settings.tableView.cell.source".localized()
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let versionCell: UITableViewCell = {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "settings.tableView.cell.appVersion".localized()
        cell.detailTextLabel?.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        cell.selectionStyle = .none
        return cell
    }()

    private let logoutCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "settings.button.signout".localized()
        cell.textLabel?.textColor = .red
        cell.textLabel?.textAlignment = .center
        cell.accessoryType = .none
        return cell
    }()

    private lazy var staticSettingsViewCells = [
        [openSourceCell, graphicCell, contributorsCell],
        [sourceCodeCell, versionCell],
        [logoutCell]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return staticSettingsViewCells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticSettingsViewCells[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return staticSettingsViewCells[indexPath.section][indexPath.row]
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "settings.tableView.section.credits".localized()
        case 1:
            return "settings.tableView.section.about".localized()
        case 2:
            return nil
        default:
            fatalError("Section unknown: \(section)")
        }
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 2 else { return nil }
        return "settings.label.madeBy".localized()
    }

    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        footer.textLabel?.textAlignment = .center
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            navigationController?.pushViewController(OSSDetailViewController(), animated: true)
        case IndexPath(row: 1, section: 0):
            navigationController?.pushViewController(GraphicsDetailViewController(), animated: true)
        case IndexPath(row: 2, section: 0):
            showWebsite(URL(string: "https://github.com/bastilimbach/timeu/graphs/contributors")!)
        case IndexPath(row: 0, section: 1):
            showWebsite(URL(string: "https://github.com/bastilimbach/timeu")!)
        case IndexPath(row: 0, section: 2):
            performLogout()
        default:
            return
        }
    }

    private func showWebsite(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }

    private func performLogout() {
        let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
        do {
            try keychain.remove("api-key")
            UserDefaults.standard.removeObject(forKey: "currentUser")
            present(LoginViewController(), animated: true)
        } catch {
            return
        }
    }

}
