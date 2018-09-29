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
    private let currentUser: User
    private var selectedCustomer: Customer?
    private var selectedProject: Proj?

    private let searchController = SearchController()
    private let informationsController = RecordInformationViewController()
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

        searchController.selectionHandler = { item in
            if let customer = item as? Customer {
                self.selectedCustomer = customer
            }

            if let project = item as? Proj {
                self.selectedProject = project
            }
            self.textViewController.deleteSearchText()
        }
    }

    private func addViews() {
        view.addSubview(stackView)
        addContentController(textViewController, to: stackView)
        addContentController(informationsController, to: stackView)
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
        let searchString = String(textView.text[index...])
        searchController.search(searchString)
    }

    func recordTextView(_ textView: UITextView, didBeginSearchFor type: SearchType) {
        removeContentController(informationsController, from: stackView)
        addContentController(searchController, to: stackView)

        switch type {
        case .customer:
            NetworkController.shared.getCustomers(for: currentUser) { result in
                switch result {
                case .success(let customers):
                    DispatchQueue.main.async {
                        self.searchController.results = customers
                    }
                case .failure:
                    ErrorMessage.show(message: "error.message.couldntReceiveCustomer".localized())
                }
            }
        case .project:
            NetworkController.shared.getProjects(for: currentUser) { result in
                switch result {
                case .success(let projects):
                    DispatchQueue.main.async {
                        self.searchController.results = projects
                    }
                case .failure:
                    ErrorMessage.show(message: "error.message.couldntReceiveProjects".localized())
                }
            }
        }
    }

    func didEndSearch(_ textView: UITextView) {
        removeContentController(searchController, from: stackView)
        addContentController(informationsController, to: stackView)
    }
}
