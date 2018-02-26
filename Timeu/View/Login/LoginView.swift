//
//  LoginView.swift
//  Timeu
//
//  Created by Sebastian Limbach on 17.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {

    var scrollViewInset: UIEdgeInsets {
        get {
            return scrollView.contentInset
        }
        set {
            scrollView.contentInset = newValue
        }
    }

    var kimaiURL: URL? {
        get {
            return URL(string: kimaiURLInput.textField.text!)
        }
        set {
            kimaiURLInput.textField.text = String(describing: newValue!)
        }
    }

    var username: String? {
        get {
            return usernameInput.textField.text
        }
        set {
            usernameInput.textField.text = newValue
        }
    }

    var password: String? {
        get {
            return passwordInput.textField.text
        }
        set {
            passwordInput.textField.text = newValue
        }
    }

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginViewBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let appLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo")
        imageView.contentMode = .top
        return imageView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let kimaiURLInput: LoginTextFieldView = {
        let fieldView = LoginTextFieldView()
        fieldView.backgroundColor = UIColor.init(r: 255, g: 255, b: 255, a: 0.6)
        fieldView.layer.cornerRadius = 5
        fieldView.layer.shadowColor = UIColor.black.cgColor
        fieldView.layer.shadowOpacity = 0.05
        fieldView.layer.shadowOffset = CGSize(width: fieldView.frame.width, height: fieldView.frame.height + 5)
        fieldView.layer.shadowRadius = 5
        fieldView.textField.tag = 1
        fieldView.textField.placeholder = "https://demo.kimai.org/"
        fieldView.textField.keyboardType = .URL
        fieldView.textField.returnKeyType = .next
        fieldView.textField.autocorrectionType = .no
        fieldView.textField.autocapitalizationType = .none
        fieldView.iconView.image = UIImage(named: "urlIcon")

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = fieldView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        fieldView.insertSubview(blurEffectView, at: 0)
        fieldView.clipsToBounds = true
        return fieldView
    }()

    let usernameInput: LoginTextFieldView = {
        let fieldView = LoginTextFieldView()
        fieldView.backgroundColor = UIColor.init(r: 255, g: 255, b: 255, a: 0.6)
        fieldView.layer.cornerRadius = 5
        fieldView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        fieldView.layer.shadowColor = UIColor.black.cgColor
        fieldView.layer.shadowOpacity = 0.05
        fieldView.layer.shadowOffset = CGSize(width: fieldView.frame.width, height: fieldView.frame.height + 5)
        fieldView.layer.shadowRadius = 5
        fieldView.textField.tag = 2
        fieldView.textField.placeholder = "Username"
        fieldView.textField.autocorrectionType = .no
        fieldView.textField.autocapitalizationType = .none
        fieldView.textField.returnKeyType = .next
        fieldView.iconView.image = UIImage(named: "userIcon")

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = fieldView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        fieldView.insertSubview(blurEffectView, at: 0)
        fieldView.clipsToBounds = true
        return fieldView
    }()

    let passwordInput: LoginTextFieldView = {
        let fieldView = LoginTextFieldView()
        fieldView.backgroundColor = UIColor.init(r: 255, g: 255, b: 255, a: 0.6)
        fieldView.layer.cornerRadius = 5
        fieldView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        fieldView.layer.shadowColor = UIColor.black.cgColor
        fieldView.layer.shadowOpacity = 0.05
        fieldView.layer.shadowOffset = CGSize(width: fieldView.frame.width, height: fieldView.frame.height + 5)
        fieldView.layer.shadowRadius = 5
        fieldView.textField.tag = 3
        fieldView.textField.placeholder = "Password"
        fieldView.textField.isSecureTextEntry = true
        fieldView.textField.autocorrectionType = .no
        fieldView.textField.returnKeyType = .go
        fieldView.iconView.image = UIImage(named: "passwordIcon")

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = fieldView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        fieldView.insertSubview(blurEffectView, at: 0)
        fieldView.clipsToBounds = true
        return fieldView
    }()

    let loginButton = LoginButton()

    let helpLink: UIButton = {
        let button = UIButton()
        button.setTitle("Need Help?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        button.titleLabel?.layer.shadowRadius = 5
        button.titleLabel?.layer.shadowOpacity = 0.8
        button.titleLabel?.layer.shadowOffset = .zero
        return button
    }()

    let demoLink: UIButton = {
        let button = UIButton()
        button.setTitle("Try the demo", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        button.titleLabel?.layer.shadowRadius = 5
        button.titleLabel?.layer.shadowOpacity = 0.8
        button.titleLabel?.layer.shadowOffset = .zero
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addViews()
        setupConstraints()
    }

    private func addViews() {
        addSubview(backgroundImageView)
        addSubview(appLogoView)
        addSubview(scrollView)
        bringSubview(toFront: appLogoView)
        scrollView.addSubview(contentView)
        contentView.addSubview(kimaiURLInput)
        contentView.addSubview(usernameInput)
        contentView.addSubview(passwordInput)
        contentView.addSubview(loginButton)
        contentView.addSubview(helpLink)
        contentView.addSubview(demoLink)
    }

    private func setupConstraints() {
        let inputPadding = 20

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        appLogoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.height.equalTo(40)
            make.width.equalTo(85)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
            make.width.equalTo(self)
        }

        kimaiURLInput.snp.makeConstraints { make in
            make.left.right.equalTo(loginButton)
            make.bottom.equalTo(usernameInput.snp.top).offset(-inputPadding)
            make.height.equalTo(loginButton).multipliedBy(1.5)
        }

        usernameInput.snp.makeConstraints { make in
            make.left.right.equalTo(loginButton)
            make.bottom.equalTo(passwordInput.snp.top)
            make.height.equalTo(loginButton).multipliedBy(1.5)
        }

        passwordInput.snp.makeConstraints { make in
            make.left.right.equalTo(loginButton)
            make.bottom.equalTo(loginButton.snp.top).offset(-inputPadding)
            make.height.equalTo(loginButton).multipliedBy(1.5)
        }

        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30).priority(750)
            make.width.lessThanOrEqualTo(600).priority(1000)
            make.centerX.equalToSuperview().priority(1000)
            make.bottom.equalTo(helpLink.snp.top).offset(-inputPadding)
            make.height.equalTo(40)
        }

        helpLink.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(30)
        }

        demoLink.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(30)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
