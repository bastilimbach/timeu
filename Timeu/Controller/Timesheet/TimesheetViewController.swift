//
//  HomeVC.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class TimesheetViewController: UIViewController {

    private let currentUser: User

    private lazy var tableView: ActivityTableView = {
        let tableView = ActivityTableView()
        tableView.dataSource = tableViewDatasource
        tableViewDelegate.pushHandler = navigateToActivityDetail
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

    func navigateToActivityDetail() {
        navigationController?.pushViewController(TimesheetViewController(currentUser: currentUser), animated: true)
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

