//
//  ActivityTableViewHeader.swift
//  Timeu
//
//  Created by Sebastian Limbach on 01.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class ActivityTableViewHeader: UIView {

    var sectionText: String? {
        get {
            return headerLabel.text
        }
        set {
            headerLabel.text = newValue?.uppercased()
        }
    }

    private var headerLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .timeuTableViewHeaderColor
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .timeuGray
        addViews()
        setupConstraints()
    }

    private func addViews() {
        addSubview(headerLabel)
    }

    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(20, 20, 5, 20))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
