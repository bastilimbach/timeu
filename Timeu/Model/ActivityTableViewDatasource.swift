//
//  ActivityTableViewDatasource.swift
//  Timeu
//
//  Created by Sebastian Limbach on 09.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActivityTableViewDatasource: NSObject, UITableViewDataSource {

    var timesheetActivities: [[Activity]]?
    var timesheetSections: [Date]?

    convenience init(activities: [[Activity]]?, sections: [Date]?) {
        self.init()
        timesheetActivities = activities
        timesheetSections = sections
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCounter = timesheetSections?.count else { return 0 }
        return sectionCounter + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timesheetActivities?[section - 1].count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: ActivityTableView.CellIdentifiers.activityStatsCell.rawValue) as! ActivityStatsTableViewCell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableView.CellIdentifiers.activityCell.rawValue) as! ActivityTableViewCell

        guard let activity = timesheetActivities?[indexPath.section - 1][indexPath.row] else { return cell }

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short

        let text = activity.description ?? "No description"
        let startTime = timeFormatter.string(from: activity.startDateTime)
        let endTime = timeFormatter.string(from: activity.endDateTime)

        cell.activityLabel.text = text
        cell.activityTime.text = "\(startTime) - \(endTime)"
        cell.delegate = tableView.delegate as? SwipeTableViewCellDelegate
        return cell
    }

}
