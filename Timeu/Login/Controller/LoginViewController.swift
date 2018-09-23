//
//  LoginViewController.swift
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
import SafariServices
import PasswordExtension

class LoginViewController: UIViewController {

    private lazy var loginView: LoginView = {
        let loginView = LoginView()
        loginView.helpLink.addTarget(self, action: #selector(showHelpWebsite(sender:)), for: .touchUpInside)
        loginView.demoLink.addTarget(self, action: #selector(insertDemoCredentials(sender:)), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        loginView.kimaiURLInput.textField.delegate = self
        loginView.usernameInput.textField.delegate = self
        loginView.passwordInput.textField.delegate = self

        let passwordExtensionBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        passwordExtensionBtn.setImage(UIImage(named: "passwordExtensionIcon"), for: .normal)
        passwordExtensionBtn.addTarget(self, action: #selector(showPasswordExtensions), for: .touchUpInside)
        loginView.passwordInput.textField.rightView = passwordExtensionBtn
        loginView.passwordInput.textField.rightViewMode = .always

        return loginView
    }()

    override func viewDidLoad() {
        view = loginView
        setupObservers()
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            var newContentInset = loginView.scrollViewInset
            newContentInset.bottom = keyboardHeight
            loginView.scrollViewInset = newContentInset
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        loginView.scrollViewInset = .zero
    }

    @objc private func showHelpWebsite(sender: UIButton) {
        let urlString = "https://sebastianlimbach.com"

        if let url = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            present(safariVC, animated: true)
        }
    }

    @objc private func insertDemoCredentials(sender: UIButton) {
        loginView.kimaiURL = URL(string: "https://demo-v2.kimai.org/")!
        loginView.username = "admin"
        loginView.password = "api"
    }

    @objc private func login(sender: UIButton) {
        performLogin()
    }

    @objc private func showPasswordExtensions() {
        var searchURL = "https://demo-v2.kimai.org/"
        if let kimaiURL = loginView.kimaiURL {
            searchURL = String(describing: kimaiURL)
        }

        PasswordExtension.shared.findLoginDetails(for: searchURL, viewController: self,
                                                  sender: nil) { [weak self] loginDetails, _ in
                                                    if let loginDetails = loginDetails {
                                                        self?.loginView.username = loginDetails.username
                                                        self?.loginView.password = loginDetails.password
                                                    }
        }
    }

    private func performLogin() {
        guard let kimaiURL = loginView.kimaiURL,
            let userName = loginView.username,
            let password = loginView.password else { return }

        loginView.loginButton.showLoading()

        let api = kimaiURL.appendingPathComponent("api")
        let user = User(userName: userName, apiEndpoint: api, apiKey: password)
        NetworkController.shared.ping(url: api, with: user) { result in
            defer {
                DispatchQueue.main.async {
                    self.loginView.loginButton.hideLoading()
                }
            }

            switch result {
            case .success(let ping):
                if ping.message == "pong" {
                    UserDefaults.standard.set(
                        ["username": user.userName, "endpoint": String(describing: user.apiEndpoint)],
                        forKey: "currentUser"
                    )
                    DispatchQueue.main.async {
                        self.present(TabBarController(currentUser: user), animated: true)
                    }
                } else {
                    ErrorMessage.show(
                        message: "\("error.message.unsupportedVersion".localized()): \(ping.version)"
                    )
                }
            case .failure(let error):
                switch error {
                case .invalidCredentials:
                    ErrorMessage.show(message: "error.message.wrongCredentials".localized())
                default:
                    ErrorMessage.show(message: "error.message.endpointConnectionError".localized())
                }
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension LoginViewController: SFSafariViewControllerDelegate {

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = loginView.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            if textField.returnKeyType == UIReturnKeyType.go {
                textField.resignFirstResponder()
                performLogin()
            }
        }
        return false
    }

}
