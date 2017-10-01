//
//  ActivityTableViewCell.swift
//  Timeu
//
//  Created by Sebastian Limbach on 29.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit
import SwipeCellKit
import Cartography

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

    open var activityLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = UIColor.init(red: 142/255, green: 151/255, blue: 185/255, alpha: 1)
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.text = "App - Onboarding Screens"
        return label
    }()

    open var activityTime: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = UIColor.lightGray
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 1
        label.text = "12:30 - 18:00 (Novoferm)"
        return label
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

    func addViews() {
        contentView.addSubview(card)
        card.addSubview(activityLabel)
        card.addSubview(activityTime)
    }

    func setupConstrains() {
        constrain(card) { card in
            card.center == card.superview!.center
            card.edges == inset(card.superview!.edges, cardPadding / 2, cardPadding, cardPadding / 2, cardPadding)
        }

        constrain(activityLabel, activityTime) { activityLabel, activityTime in
            let container = activityLabel.superview!

            activityLabel.top == container.top + 10
            activityLabel.right == container.right - 10
            activityLabel.left == container.left + 10
            align(left: [activityLabel, activityTime])
            align(right: [activityLabel, activityTime])
            distribute(by: 5, vertically: [activityLabel, activityTime])
            activityTime.bottom == container.bottom - 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            card.backgroundColor = UIColor.lightGray
        } else {
            card.backgroundColor = UIColor.white
        }
    }

}
