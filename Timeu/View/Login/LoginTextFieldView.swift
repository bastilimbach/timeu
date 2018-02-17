//
//  LoginTextFieldView.swift
//  Timeu
//
//  Created by Sebastian Limbach on 17.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
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

    let actionButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }

    private func addViews() {
        addSubview(textField)
        addSubview(iconView)
        addSubview(actionButton)
    }

    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(actionButton.snp.left).offset(-15)
            make.left.equalTo(iconView.snp.right).offset(15)
            make.height.equalTo(20)
        }

        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(textField)
            make.width.equalTo(textField.snp.height)
            make.centerY.equalToSuperview()
        }

        actionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(textField)
            make.width.equalTo(textField.snp.height)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
