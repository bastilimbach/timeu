//
//  RecordCreationController.swift
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

final class RecordCreationController: UIViewController {
    private let currentUser: User?

    private let informationController = CustomerSearchController()
    private lazy var textViewController: RecordTextViewController = {
        let controller = RecordTextViewController()
        controller.delegate = self
        return controller
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "recordCreation.navigationTitle".localized()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self, action: #selector(cancelCreation))

        addViews()
        setupConstraints()
    }

    private func addViews() {
        view.addSubview(stackView)
        addContentController(textViewController, to: stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addContentController(_ child: UIViewController, to stackView: UIStackView) {
        addChildViewController(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParentViewController: self)
    }

    private func removeContentController(_ child: UIViewController, from stackView: UIStackView) {
        child.willMove(toParentViewController: nil)
        stackView.removeArrangedSubview(child.view)
        child.removeFromParentViewController()
    }

    @objc private func cancelCreation() {
        dismiss(animated: true)
    }

}

extension RecordCreationController: RecordTextViewDelegate {
    func recordTextView(_ textView: UITextView, didChangeSearchTermAt index: String.Index, for type: SearchType) {
        print(textView.text[index...])
    }

    func recordTextView(_ textView: UITextView, didBeginSearchFor type: SearchType) {
        addContentController(informationController, to: stackView)
    }

    func didEndSearch(_ textView: UITextView) {
        removeContentController(informationController, from: stackView)
    }
}
