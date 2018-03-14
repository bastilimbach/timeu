//
//  TimesheetViewController.swift
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
import SnapKit

class TimesheetViewController: UIViewController {

    private let currentUser: User

    private lazy var tableView: ActivityTableView = {
        let tableView = ActivityTableView()
        tableView.dataSource = tableViewDatasource
        tableViewDelegate.pushHandler = navigateToActivityDetail(activity:)
        tableView.delegate = tableViewDelegate

        tableView.refreshControl?.addTarget(self, action: #selector(getTimesheet), for: .valueChanged)
        return tableView
    }()

    let tableViewDatasource = ActivityTableViewDatasource()
    let tableViewDelegate = ActivityTableViewDelegate()

    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        getTimesheet()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }

    private func navigateToActivityDetail(activity: Activity) {
        navigationController?.pushViewController(TimesheetRecordDetailsViewController(forRecord: activity), animated: true)
    }

    @objc func getTimesheet(_ refreshControl: UIRefreshControl? = nil) {
        NetworkController.shared.getTimesheetFor(currentUser) { [weak self] result in
            if case let .success(activites) = result {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short

                var lastDate: Date = activites[0].startDateTime
                var tempTimesheetActivities: [[Activity]] = [[activites[0]]]
                var tempTimesheetSections: [Date] = [lastDate]
                var sectionIndex: Int = 0

                for (index, activity) in activites.enumerated() where index != 0 {
                    let dateComparison = Calendar.current.compare(lastDate, to: activity.startDateTime, toGranularity: .day)
                    if dateComparison != .orderedSame {
                        sectionIndex += 1
                        lastDate = activity.startDateTime
                        tempTimesheetSections.append(lastDate)
                        tempTimesheetActivities.append([activity])
                    } else {
                        tempTimesheetActivities[sectionIndex].append(activity)
                    }
                }

                self?.tableViewDatasource.timesheetActivities = tempTimesheetActivities
                self?.tableViewDatasource.timesheetSections = tempTimesheetSections
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
}

