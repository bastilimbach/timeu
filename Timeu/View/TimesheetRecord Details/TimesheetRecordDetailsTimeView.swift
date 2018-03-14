//
//  TimesheetRecordDetailsTimeView.swift
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

class TimesheetRecordDetailsTimeView: UIStackView {

    var startTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        return timeLabel
    }()

    var startDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        return dateLabel
    }()

    private let leftDateTimeView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var endTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        timeLabel.textAlignment = .right
        return timeLabel
    }()

    var endDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        dateLabel.textAlignment = .right
        return dateLabel
    }()

    private let rightDateTimeView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let dotsView: UIView = {
        let view = UIView()
        let size = 5
        let margin = 10

        let firstDot = CAShapeLayer()
        firstDot.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: size, height: size)).cgPath
        firstDot.fillColor = UIColor.timeuGrayTone1.cgColor
        let secondDot = CAShapeLayer()
        secondDot.path = UIBezierPath.init(ovalIn: CGRect.init(x: size + margin, y: 0, width: size, height: size)).cgPath
        secondDot.fillColor = UIColor.timeuGrayTone2.cgColor
        let thirdDot = CAShapeLayer()
        thirdDot.path = UIBezierPath.init(ovalIn: CGRect.init(x: (size + margin) * 2, y: 0, width: size, height: size)).cgPath
        thirdDot.fillColor = UIColor.timeuGrayTone3.cgColor

        view.layer.addSublayer(firstDot)
        view.layer.addSublayer(secondDot)
        view.layer.addSublayer(thirdDot)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .equalSpacing
        alignment = .center

        addViews()
        setupConstraints()
    }

    private func addViews() {
        addArrangedSubview(leftDateTimeView)
        addArrangedSubview(dotsView)
        addArrangedSubview(rightDateTimeView)

        rightDateTimeView.addArrangedSubview(endTimeLabel)
        rightDateTimeView.addArrangedSubview(endDateLabel)
        leftDateTimeView.addArrangedSubview(startTimeLabel)
        leftDateTimeView.addArrangedSubview(startDateLabel)
    }

    private func setupConstraints() {
        leftDateTimeView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }

        dotsView.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(5)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
