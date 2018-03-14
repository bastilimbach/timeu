//
//  TimesheetRecordDetailsView.swift
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

class TimesheetRecordDetailsView: UIView {

    var descriptionText: String? {
        get {
            return descriptionTextView.text
        }
        set {
            descriptionTextView.text = newValue
        }
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let detailsCardView = TimesheetRecordDetailsCardView()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.backgroundColor = .clear
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .timeuGray

        addViews()
        setupConstraints()
    }

    private func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(detailsCardView)
        contentView.addSubview(descriptionTextView)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
            make.width.equalTo(self)
        }

        detailsCardView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.right.equalToSuperview().inset(20)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(detailsCardView.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(35)
            make.height.greaterThanOrEqualTo(100).priority(1000)
            make.bottom.equalToSuperview().inset(20).priority(750)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
