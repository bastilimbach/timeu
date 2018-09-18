//
//  ActivityTableView.swift
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

class ActivityTableView: UITableView {

    enum CellIdentifiers: String {
        case activityCell = "tableViewCell"
        case activityStatsCell = "tableViewCellWithCollectionView"
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = .timeuGray
        separatorStyle = .none
        estimatedRowHeight = 50
        rowHeight = UITableView.automaticDimension
        estimatedSectionHeaderHeight = 50
        refreshControl = UIRefreshControl()

        register(ActivityTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.activityCell.rawValue)
        register(ActivityStatsTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.activityStatsCell.rawValue)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
