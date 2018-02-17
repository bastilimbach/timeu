//
//  ActivityStatsCollectionViewCell.swift
//  Timeu
//
//  Created by Sebastian Limbach on 10.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class ActivityStatsCollectionViewCell: UICollectionViewCell {

    var number: Int? {
        get {
            guard let text = numberLabel.text else { return nil }
            return Int(text)
        }
        set {
            numberLabel.text = String(describing: newValue ?? 0)
        }
    }

    var numberDescription: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }

    private let box: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: view.frame.width, height: view.frame.height + 5)
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        return view
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .timeuHighlightText
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 76, weight: UIFont.Weight.heavy)
        return label
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .timeuTextBlack
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear

        addViews()
        setupConstrains()
    }

    private func addViews() {
        contentView.addSubview(box)
        box.addSubview(numberLabel)
        box.addSubview(textLabel)
    }

    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(160)
        }

        box.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }

        numberLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }

        textLabel.snp.makeConstraints { make in
            make.width.equalTo(numberLabel.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(numberLabel.snp.bottom).offset(-5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
