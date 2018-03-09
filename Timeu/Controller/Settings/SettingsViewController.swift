//
//  SettingsViewController.swift
//  Timeu
//
//  Created by Sebastian Limbach on 08.03.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SafariServices
import KeychainAccess

class SettingsViewController: UITableViewController {

    private let openSourceCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Open Source Software"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let graphicCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Graphics & Images"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let contributorsCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Contributors"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let sourceCodeCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Source code"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()

    private let versionCell: UITableViewCell = {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "App Version"
        cell.detailTextLabel?.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        cell.selectionStyle = .none
        return cell
    }()

    private let logoutCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Sign out"
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
            return "Credits"
        case 1:
            return "About"
        case 2:
            return nil
        default:
            fatalError("Section unknown: \(section)")
        }
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 2 else { return nil }
        return "Timeu is built by Sebastian Limbach"
    }

    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
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
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
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
