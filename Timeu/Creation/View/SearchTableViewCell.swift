//
//  SearchTableViewCell.swift
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

class SearchTableViewCell: UITableViewCell, Identifiable {

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

    private let customerLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .timeuTextBlack
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    private let cardPadding: CGFloat = 20

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor.clear
        selectionStyle = .none

        addViews()
        setupConstrains()
    }

    private func addViews() {
        addSubview(card)
        card.addSubview(customerLabel)
    }

    private func setupConstrains() {
        card.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: cardPadding / 3, left: cardPadding, bottom: cardPadding / 3, right: cardPadding
            ))
        }

        customerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

extension SearchTableViewCell: ConfigurableCell {
    func configure(object: Searchable) {
        customerLabel.text = object.searchableString
    }
}
