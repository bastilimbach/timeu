//
//  ActivityTableView.swift
//  Timeu
//
//  Created by Sebastian Limbach on 09.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit

class ActivityTableView: UITableView {

    enum CellIdentifiers: String {
        case activityCell = "tableViewCell"
        case activityStatsCell = "tableViewCellWithCollectionView"
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        backgroundColor = .timeuGray
        separatorStyle = .none
        estimatedRowHeight = 50
        rowHeight = UITableViewAutomaticDimension
        estimatedSectionHeaderHeight = 50
        refreshControl = UIRefreshControl()

        register(ActivityTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.activityCell.rawValue)
        register(ActivityStatsTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.activityStatsCell.rawValue)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
