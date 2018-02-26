//
//  HomeTableViewDelegate.swift
//  Timeu
//
//  Created by Sebastian Limbach on 09.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SwipeCellKit

class ActivityTableViewDelegate: NSObject, UITableViewDelegate {

    var pushHandler: (() -> Void)?

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNonzeroMagnitude
        }
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let header = ActivityTableViewHeader()
        guard let dataSource = tableView.dataSource as? ActivityTableViewDatasource,
            let sectionDate = dataSource.timesheetSections?[section - 1] else { return header }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full

        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        switch dateFormatter.string(from: sectionDate) {
        case dateFormatter.string(from: today):
            header.sectionText = "Today".localized()
        case dateFormatter.string(from: yesterday):
            header.sectionText = "Yesterday".localized()
        default:
            header.sectionText = dateFormatter.string(from: sectionDate)
        }

        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushHandler?()
    }
    
}

extension ActivityTableViewDelegate: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "DeleteActionTitle".localized()) { _, _ in
            print("Delete action triggerd!")
        }
        deleteAction.image = UIImage(named: "deleteIcon")
        deleteAction.backgroundColor = .timeuGray
        deleteAction.highlightedBackgroundColor = .timeuGray
        deleteAction.textColor = .lightGray

        let duplicateAction = SwipeAction(style: .default, title: "DuplicateActionTitle".localized()) { _, _ in
            print("Save action triggerd!")
        }
        duplicateAction.image = UIImage(named: "duplicateIcon")
        duplicateAction.backgroundColor = .timeuGray
        duplicateAction.highlightedBackgroundColor = .timeuGray
        duplicateAction.textColor = .lightGray
        duplicateAction.font = .systemFont(ofSize: 8)


        switch orientation {
        case .right:
            return [deleteAction]
        case .left:
            return [duplicateAction, duplicateAction]
        }

    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.transitionStyle = .drag
        options.backgroundColor = .clear

        switch orientation {
        case .right:
            options.expansionStyle = .destructiveAfterFill
        case .left:
            options.expansionStyle = .selection
            options.expansionDelegate = ScaleAndAlphaExpansion.default
        }

        return options
    }

}
