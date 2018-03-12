//
//  ActivityTableViewCell.swift
//  Timeu
//
//  Created by Sebastian Limbach on 29.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import SwipeCellKit
import SnapKit

class ActivityTableViewCell: SwipeTableViewCell {

    private let card: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: view.frame.width, height: view.frame.height + 5)
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        return view
    }()

    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        return label
    }()

    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        return label
    }()

    private let dotsView: UIView = {
        let view = UIView()
        let size = 2
        let margin = 3

        let firstDot = CAShapeLayer()
        firstDot.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: size, height: size)).cgPath
        firstDot.fillColor = UIColor.timeuGrayTone3.cgColor
        let secondDot = CAShapeLayer()
        secondDot.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: size + margin, width: size, height: size)).cgPath
        secondDot.fillColor = UIColor.timeuGrayTone2.cgColor
        let thirdDot = CAShapeLayer()
        thirdDot.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: (size + margin) * 2, width: size, height: size)).cgPath
        thirdDot.fillColor = UIColor.timeuGrayTone1.cgColor

        view.layer.addSublayer(firstDot)
        view.layer.addSublayer(secondDot)
        view.layer.addSublayer(thirdDot)

        return view
    }()

    private let timeView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    let customerLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .timeuTextBlack
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    let projectLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .timeuSubheaderColor
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()

    private let disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disclosureIndicator")
        imageView.contentMode = .center
        return imageView
    }()

    private let cardPadding: CGFloat = 20

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor.clear
        selectionStyle = .none

        addViews()
        setupConstrains()
    }

    private func addViews() {
        addSubview(card)
        card.addSubview(timeView)
        card.addSubview(customerLabel)
        card.addSubview(projectLabel)
        card.addSubview(disclosureIndicator)

        timeView.addArrangedSubview(endTimeLabel)
        timeView.addArrangedSubview(dotsView)
        timeView.addArrangedSubview(startTimeLabel)
    }

    private func setupConstrains() {
        card.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(cardPadding / 3, cardPadding, cardPadding / 3, cardPadding))
        }

        dotsView.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(12)
        }

        timeView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
        customerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(timeView.snp.right).offset(10)
            make.right.equalTo(disclosureIndicator.snp.left).offset(-5)
        }
        
        projectLabel.snp.makeConstraints { make in
            make.left.right.equalTo(customerLabel)
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(customerLabel.snp.bottom).offset(5)
        }

        disclosureIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            card.backgroundColor = UIColor.init(r: 234, g: 234, b: 234, a: 1)
        } else {
            card.backgroundColor = UIColor.white
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            card.backgroundColor = UIColor.init(r: 234, g: 234, b: 234, a: 1)
        } else {
            card.backgroundColor = UIColor.white
        }
    }

}
