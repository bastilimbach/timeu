//
//  ActivityTableViewDatasource.swift
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
import SwipeCellKit

class ActivityTableViewDatasource: NSObject, UITableViewDataSource {

    var timesheetRows: [[Any]]?
    var timesheetSections: [Date]?
    var collectionViewDatasource = ActivityStatsCollectionViewDatasource()

    func numberOfSections(in tableView: UITableView) -> Int {
        return timesheetSections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timesheetRows?[section].count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = timesheetRows?[indexPath.section][indexPath.row] else { return UITableViewCell() }

        if indexPath.section == 0 {
            guard let timesheetStats = timesheetRows?[indexPath.section]
                as? [TimesheetStats] else { return UITableViewCell() }
            return getCell(forTimesheetStats: timesheetStats, of: tableView)
        }

        guard let activity = row as? Activity else { return UITableViewCell() }
        return getCell(forTimesheetRecord: activity, of: tableView)
    }

    private func getCell(forTimesheetRecord record: Activity, of tableView: UITableView) -> ActivityTableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ActivityTableView.CellIdentifiers.activityCell.rawValue
            ) as? ActivityTableViewCell else { return ActivityTableViewCell() }

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short

        cell.customerLabel.text = record.customerName
        cell.projectLabel.text = record.projectName
        cell.startTimeLabel.text = timeFormatter.string(from: record.startDateTime)
        cell.endTimeLabel.text = timeFormatter.string(from: record.endDateTime)
        cell.delegate = tableView.delegate as? SwipeTableViewCellDelegate

        return cell
    }

    private func getCell(forTimesheetStats stats: [TimesheetStats],
                         of tableView: UITableView) -> ActivityStatsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ActivityTableView.CellIdentifiers.activityStatsCell.rawValue
            ) as? ActivityStatsTableViewCell else { return ActivityStatsTableViewCell() }

        collectionViewDatasource.setStats(newStats: stats)
        cell.collectionView.dataSource = collectionViewDatasource
        cell.collectionView.reloadData()

        return cell
    }

}
