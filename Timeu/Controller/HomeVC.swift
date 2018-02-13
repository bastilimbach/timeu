//
//  HomeVC.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {

    private let tableView: ActivityTableView = {
        let tableView = ActivityTableView()
        tableView.refreshControl?.addTarget(self, action: #selector(getTimesheet), for: .valueChanged)
        return tableView
    }()

    let tableViewDatasource = ActivityTableViewDatasource()
    let tableViewDelegate = ActivityTableViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

        tableView.dataSource = self.tableViewDatasource
        tableView.delegate = self.tableViewDelegate

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        getTimesheet()
    }

    @objc func getTimesheet(_ refreshControl: UIRefreshControl? = nil) {
        NetworkController.shared.getTimesheetFor(user: User(id: 538326004, userName: "gam_limbach", firstName: nil, lastName: nil), token: "4afb8fa15ac574e8a49dc611d") { (activities, error) in
            guard let activities = activities else { print(error!); return }

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short

            var lastDate: Date = activities[0].startDateTime
            var tempTimesheetActivities: [[Activity]] = [[activities[0]]]
            var tempTimesheetSections: [Date] = [lastDate]
            var sectionIndex: Int = 0

            for (index, activity) in activities.enumerated() where index != 0 {
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

            self.tableViewDatasource.timesheetActivities = tempTimesheetActivities
            self.tableViewDatasource.timesheetSections = tempTimesheetSections
            self.tableView.reloadData()
            refreshControl?.endRefreshing()
        }
    }
    
}

