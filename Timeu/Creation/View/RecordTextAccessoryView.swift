//
//  RecordTextAccessoryView.swift
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

class RecordTextAccessoryView: UIView {

    let atSymbolButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .light)
        button.setTitle("@", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }()

    let hashSymbolButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .light)
        button.setTitle("#", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }()

    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .timeuHighlight
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 25)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        return button
    }()

    var accessoryDescription: String? {
        didSet {
            if accessoryDescription == nil {
                stackView.removeArrangedSubview(accessoryView)
                stackView.insertArrangedSubview(symbolStackView, at: 0)
                accessoryView.removeFromSuperview()
            } else {
                accessoryView.text = accessoryDescription
                stackView.removeArrangedSubview(symbolStackView)
                stackView.insertArrangedSubview(accessoryView, at: 0)
                symbolStackView.removeFromSuperview()
            }
        }
    }

    private let accessoryView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .timeuGrayTone2
        return label
    }()

    private lazy var symbolStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [atSymbolButton, hashSymbolButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 8.0
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(symbolStackView)
        stackView.addArrangedSubview(addButton)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        symbolStackView.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(100)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
