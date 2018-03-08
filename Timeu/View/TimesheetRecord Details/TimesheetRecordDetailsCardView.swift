//
//  TimesheetRecordDetailsCardView.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class TimesheetRecordDetailsCardView: UIView {

    var day: String? {
        get {
            return dayLabel.text
        }
        set {
            dayLabel.text = newValue
        }
    }

    var task: String? {
        get {
            return taskLabel.text
        }
        set {
            taskLabel.text = newValue
        }
    }

    var customer: String? {
        get {
            return customerLabel.text
        }
        set {
            customerLabel.text = newValue
        }
    }

    var project: String? {
        get {
            return projectLabel.text
        }
        set {
            projectLabel.text = newValue
        }
    }

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()

    private let taskLabel: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 10, weight: .bold)
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainerInset = UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15)
        textView.backgroundColor = .timeuHighlight
        textView.textColor = .white
        textView.layer.cornerRadius = 5
        return textView
    }()

    private let dayView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    private let customerLabel: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15, weight: .bold)
        textView.textContainerInset = .zero
        textView.textAlignment = .right
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()

    private let projectLabel: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 12, weight: .medium)
        textView.textAlignment = .right
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()

    private let customerProjectView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    let startEndTimeView = TimesheetRecordDetailsTimeView()

    private let startTimeTitle: UILabel = {
        let label = UILabel()
        label.text = "StartTimeTitle".localized().uppercased()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .timeuGrayTone1
        return label
    }()

    private let endTimeTitle: UILabel = {
        let label = UILabel()
        label.text = "EndTimeTitle".localized().uppercased()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .right
        label.textColor = .timeuGrayTone1
        return label
    }()

    private let startEndTitleView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: frame.width, height: frame.height + 5)
        layer.shadowRadius = 5
        layer.cornerRadius = 5

        addViews()
        setupConstraints()
    }

    private func addViews() {
        addSubview(dayView)
        dayView.addArrangedSubview(dayLabel)
        dayView.addArrangedSubview(taskLabel)

        addSubview(customerProjectView)
        customerProjectView.addArrangedSubview(customerLabel)
        customerProjectView.addArrangedSubview(projectLabel)

        addSubview(startEndTitleView)
        startEndTitleView.addArrangedSubview(startTimeTitle)
        startEndTitleView.addArrangedSubview(endTimeTitle)

        addSubview(startEndTimeView)
    }

    private func setupConstraints() {
        dayView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(15)
        }

        customerProjectView.snp.makeConstraints { make in
            make.left.right.equalTo(dayView)
            make.top.equalTo(dayView.snp.bottom).offset(40)
        }

        startEndTimeView.snp.makeConstraints { make in
            make.top.equalTo(customerProjectView.snp.bottom).offset(40)
            make.left.right.equalTo(dayView)
            make.bottom.equalToSuperview().inset(15)
        }

        startEndTitleView.snp.makeConstraints { make in
            make.left.right.equalTo(dayView)
            make.bottom.equalTo(startEndTimeView).offset(-15)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
