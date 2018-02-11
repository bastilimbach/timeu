//
//  ActivityStatsTableViewCell.swift
//  Timeu
//
//  Created by Sebastian Limbach on 10.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class ActivityStatsTableViewCell: UITableViewCell {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ActivityStatsCollectionViewCell.self, forCellWithReuseIdentifier: "unknown")
        return collectionView
    }()

    private let collectionViewDatasource = ActivityStatsCollectionViewDatasource()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        collectionView.dataSource = collectionViewDatasource

        addViews()
        setupConstrains()
    }

    private func addViews() {
        addSubview(collectionView)
    }

    private func setupConstrains() {
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
