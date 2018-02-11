//
//  ActivityStatsCollectionViewDatasource.swift
//  Timeu
//
//  Created by Sebastian Limbach on 10.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit

class ActivityStatsCollectionViewDatasource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unknown", for: indexPath) as! ActivityStatsCollectionViewCell
        cell.number = 47
        cell.numberDescription = "Stunden diesen Monat"
        return cell
    }

}
