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
    private let tableViewDatasource = ActivityTableViewDatasource()
    private let tableViewDelegate = ActivityTableViewDelegate() // needs more investigation

    private lazy var tableView: ActivityTableView = {
        let tableView = ActivityTableView()
        tableView.dataSource = tableViewDatasource
        tableViewDelegate.pushHandler = navigateToActivityDetail(activity:)
        tableView.delegate = tableViewDelegate

        tableView.refreshControl?.addTarget(self, action: #selector(getTimesheet), for: .valueChanged)
        return tableView
    }()

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
        navigationController?.pushViewController(
            TimesheetRecordDetailsViewController(forRecord: activity),
            animated: true
        )
    }

    @objc private func getTimesheet(_ refreshControl: UIRefreshControl? = nil) {
        NetworkController.shared.getTimesheetFor(currentUser) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.refreshControl?.endRefreshing()
                }
            }

            if case let .success(activities) = result {
                if activities.isEmpty {
                    ErrorMessage.show(message: "error.message.noTimesheetRecords".localized(), withTheme: .warning)
                    self?.tableViewDatasource.timesheetRows = nil
                    self?.tableViewDatasource.timesheetSections = nil
                    return
                }

                var lastDate: Date = activities[0].startDateTime
                var tempTimesheetRecords = [[Any]()]
                var tempTimesheetSections: [Date] = [lastDate]
                var sectionIndex: Int = 0

                for activity in activities {
                    let dateComparison = Calendar.current.compare(
                        lastDate,
                        to: activity.startDateTime,
                        toGranularity: .day
                    )
                    if dateComparison != .orderedSame {
                        sectionIndex += 1
                        lastDate = activity.startDateTime
                        tempTimesheetSections.append(lastDate)
                        tempTimesheetRecords.append([activity])
                    } else {
                        tempTimesheetRecords[sectionIndex].append(activity)
                    }
                }

                let stats = self?.getTimesheetStats(forRecords: activities)
                if let stats = stats {
                    tempTimesheetRecords.insert(stats, at: 0)
                }
                tempTimesheetSections.insert(lastDate, at: 0)
                self?.tableViewDatasource.timesheetRows = tempTimesheetRecords
                self?.tableViewDatasource.timesheetSections = tempTimesheetSections
            } else if case .failure = result {
                ErrorMessage.show(message: "error.message.couldntReceiveRecords".localized())
            }
        }
    }

    private func getTimesheetStats(forRecords activities: [Activity]) -> [TimesheetStats] {
        var secondsToday = 0
        var secondsThisWeek = 0
        var secondsThisMonth = 0

        for activity in activities {
            let secondsDifferences = Calendar.current.dateComponents([.second],
                                                                     from: activity.startDateTime,
                                                                     to: activity.endDateTime).second ?? 0
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
        }

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .pad

        return [
            TimesheetStats(
                time: formatter.string(from: TimeInterval(secondsToday))!,
                description: "timesheet.stats.today".localized()
            ),
            TimesheetStats(
                time: formatter.string(from: TimeInterval(secondsThisWeek))!,
                description: "timesheet.stats.week".localized()
            ),
            TimesheetStats(
                time: formatter.string(from: TimeInterval(secondsThisMonth))!,
                description: "timesheet.stats.month".localized()
            )
        ]
    }

}
