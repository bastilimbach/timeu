//
//  ActivityStatsCollectionViewDatasource.swift
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

class ActivityStatsCollectionViewDatasource: NSObject, UICollectionViewDataSource {

    var stats: [TimesheetStats]?

    convenience init(stats: [TimesheetStats]) {
        self.init()
        self.stats = stats
    }

    func setStats(newStats: [TimesheetStats]) {
        self.stats = newStats
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stats?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "unknown",
                for: indexPath
            ) as? ActivityStatsCollectionViewCell else { return ActivityStatsCollectionViewCell() }
        cell.number = stats?[indexPath.row].time
        cell.numberDescription = stats?[indexPath.row].description
        return cell
    }

}
