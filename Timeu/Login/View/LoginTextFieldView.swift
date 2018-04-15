//
//  LoginTextFieldView.swift
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

class LoginTextFieldView: UIView {

    let textField = UITextField()

    let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }

    private func addViews() {
        addSubview(textField)
        addSubview(iconView)
    }

    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
            make.left.equalTo(iconView.snp.right).offset(15)
            make.height.equalTo(20)
        }

        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(textField)
            make.width.equalTo(textField.snp.height)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
