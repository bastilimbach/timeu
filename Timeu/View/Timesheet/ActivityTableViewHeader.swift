//
//  ActivityTableViewHeader.swift
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
