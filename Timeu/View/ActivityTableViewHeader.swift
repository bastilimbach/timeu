//
//  ActivityTableViewHeader.swift
//  Timeu
//
//  Created by Sebastian Limbach on 01.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import Cartography

class ActivityTableViewHeader: UIView {

    open var sectionText: String? {
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
        label.textColor = UIColor.lightGray
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

    func addViews() {
        addSubview(headerLabel)
    }

    func setupConstraints() {
        constrain(headerLabel) { headerLabel in
            headerLabel.edges == inset(headerLabel.superview!.edges, 20, 20, 5, 20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
