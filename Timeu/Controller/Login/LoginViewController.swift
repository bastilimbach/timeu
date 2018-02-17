//
//  LoginViewController.swift
//  Timeu
//
//  Created by Sebastian Limbach on 17.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    private let loginView: LoginView = {
        let loginView = LoginView()
        loginView.helpLink.addTarget(self, action: #selector(showHelpWebsite(sender:)), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        return loginView
    }()

    override func viewDidLoad() {
        view = loginView
        setupObservers()
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
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
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }

    @objc private func login(sender: UIButton) {
        present(TabBarController(), animated: true)
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
