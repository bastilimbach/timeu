//
//  HomeVC.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import SwipeCellKit

class HomeVC: UITableViewController {

    var timesheetActivities: [[Activity]]? {
        didSet {
            tableView.reloadData()
        }
    }

    var timesheetSections: [Date]? {
        didSet {
            tableView.reloadData()
        }
    }

    let cellIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("HomeVCTitle", comment: "")
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "ActivityRefreshConrolText".localized())
        refreshControl?.addTarget(self, action: #selector(getTimesheet), for: .valueChanged)
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

            self.timesheetActivities = tempTimesheetActivities
            self.timesheetSections = tempTimesheetSections
            refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return timesheetSections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesheetActivities?[section].count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ActivityTableViewCell

        guard let activity = timesheetActivities?[indexPath.section][indexPath.row] else { return cell }

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short

        let text = activity.description
        let startTime = timeFormatter.string(from: activity.startDateTime)
        let endTime = timeFormatter.string(from: activity.endDateTime)

        cell.activityLabel.text = text
        cell.activityTime.text = "\(startTime) - \(endTime)"
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ActivityTableViewHeader()
        guard let sectionDate = timesheetSections?[section] else { return header }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full

        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

//        let dateComparison = Calendar.current.compare(lastDate, to: activity.startDateTime, toGranularity: .day)

        switch sectionDate {
        case today:
            header.sectionText = "Today".localized()
        case yesterday:
            header.sectionText = "Yesterday".localized()
        default:
            header.sectionText = dateFormatter.string(from: sectionDate)
        }

        return header
    }

}

extension HomeVC: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "DeleteActionTitle".localized()) { _, _ in
            print("Delete action triggerd!")
        }

        let duplicateAction = SwipeAction(style: .default, title: "DuplicateActionTitle".localized()) { _, _ in
            print("Save action triggerd!")
        }
        duplicateAction.backgroundColor = .timeuGray
        duplicateAction.textColor = .lightGray

        switch orientation {
        case .right:
            return [deleteAction]
        case .left:
            return [duplicateAction]
        }

    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        guard orientation == .left else { return SwipeTableOptions() }
        var options = SwipeTableOptions()
        options.expansionStyle = SwipeExpansionStyle.selection
        options.backgroundColor = .clear
        return options
    }

}
