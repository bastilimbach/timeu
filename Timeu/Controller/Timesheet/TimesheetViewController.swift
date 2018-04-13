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
                var tempTimesheetRecords = [[Any]()]
                var tempTimesheetSections: [Date] = [lastDate]
                var sectionIndex: Int = 0

                var secondsToday = 0
                var secondsThisWeek = 0
                var secondsThisMonth = 0

                for activity in activites {
                    let secondsDifferences = Calendar.current.dateComponents([.second], from: activity.startDateTime, to: activity.endDateTime).second ?? 0
                    let day = Calendar.current.compare(activity.startDateTime, to: Date(), toGranularity: .day)
                    if day == .orderedSame {
                        secondsToday += secondsDifferences
                    }

                    let week = Calendar.current.compare(activity.startDateTime, to: Date(), toGranularity: .weekOfYear)
                    if week == .orderedSame {
                        secondsThisWeek += secondsDifferences
                    }

                    let month = Calendar.current.compare(activity.startDateTime, to: Date(), toGranularity: .month)
                    if month == .orderedSame {
                        secondsThisMonth += secondsDifferences
                    }

                    let dateComparison = Calendar.current.compare(lastDate, to: activity.startDateTime, toGranularity: .day)
                    if dateComparison != .orderedSame {
                        sectionIndex += 1
                        lastDate = activity.startDateTime
                        tempTimesheetSections.append(lastDate)
                        tempTimesheetRecords.append([activity])
                    } else {
                        tempTimesheetRecords[sectionIndex].append(activity)
                    }
                }

                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.hour, .minute]
                formatter.zeroFormattingBehavior = .pad

                let statsArray = [
                    TimesheetStats(time: formatter.string(from: TimeInterval(secondsToday))!, description: "Hours today"),
                    TimesheetStats(time: formatter.string(from: TimeInterval(secondsThisWeek))!, description: "Hours this week"),
                    TimesheetStats(time: formatter.string(from: TimeInterval(secondsThisMonth))!, description: "Hours this month")
                ]

                tempTimesheetRecords.insert(statsArray, at: 0)
                tempTimesheetSections.insert(lastDate, at: 0)
                self?.tableViewDatasource.timesheetRows = tempTimesheetRecords
                self?.tableViewDatasource.timesheetSections = tempTimesheetSections
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
}

