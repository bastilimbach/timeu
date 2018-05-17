//
//  RecordTextViewController.swift
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

enum SearchType {
    case project
    case customer
    func searchString() -> String {
        switch self {
        case .project:
            let type = "recordCreation.accessoryView.project".localized()
            let str = String(format:
                NSLocalizedString("recordCreation.accessoryView.search", comment: ""), type)
            return str
        case .customer:
            let type = "recordCreation.accessoryView.customer".localized()
            let str = String(format:
                NSLocalizedString("recordCreation.accessoryView.search", comment: ""), type)
            return str
        }
    }
}

protocol RecordTextViewDelegate: class {
    func recordTextView(_ textView: UITextView, didChangeSearchTermAt index: String.Index, for type: SearchType)
    func recordTextView(_ textView: UITextView, didBeginSearchFor type: SearchType)
    func didEndSearch(_ textView: UITextView)
}

extension RecordTextViewDelegate {
    func recordTextView(_ textView: UITextView, didChangeSearchTermAt index: String.Index, for type: SearchType) {}
    func recordTextView(_ textView: UITextView, didBeginSearchFor type: SearchType) {}
    func didEndSearch(_ textView: UITextView) {}
}

class RecordTextViewController: UIViewController {

    weak var delegate: RecordTextViewDelegate?
    private var currentSearch: SearchType?
    private var searchKeyIndex: String.Index?

    private lazy var textView: RecordTextView = {
        let textView = RecordTextView()
        textView.intrinsicContentHeight = 80
        textView.delegate = self
        return textView
    }()

    private lazy var accessoryView: RecordTextAccessoryView = {
        let accessoryView = RecordTextAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        accessoryView.addButton.addTarget(self, action: #selector(addAtCharacter), for: .touchUpInside)
        accessoryView.atSymbolButton.addTarget(self, action: #selector(addAtCharacter), for: .touchUpInside)
        accessoryView.hashSymbolButton.addTarget(self, action: #selector(addHashCharacter), for: .touchUpInside)
        return accessoryView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = textView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    override var inputAccessoryView: UIView? {
        return accessoryView
    }

    @objc private func addAtCharacter() {
        textView.text.append("@")
        beginSearch(for: .customer, at: textView.text.endIndex)
    }

    @objc private func addHashCharacter() {
        textView.text.append("#")
        beginSearch(for: .project, at: textView.text.endIndex)
    }

    private func beginSearch(for type: SearchType, at index: String.Index) {
        currentSearch = type
        searchKeyIndex = index
        accessoryView.accessoryDescription = type.searchString()
        delegate?.recordTextView(textView, didBeginSearchFor: type)
    }

}

extension RecordTextViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let searchType = currentSearch {
            if let index = searchKeyIndex {
                delegate?.recordTextView(textView, didChangeSearchTermAt: index, for: searchType)
            }
        } else {
            guard let lastCharacter = textView.text.last else { return }
            if lastCharacter == "@" {
                beginSearch(for: .customer, at: textView.text.endIndex)
            }
            if lastCharacter == "#" {
                beginSearch(for: .project, at: textView.text.endIndex)
            }
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let original = textView.text.last else { return true }
        let disallowedCharacters = ["\n", "@", "#"]
        if original == "@" || original == "#" {
            if text == "" {
                currentSearch = nil
                accessoryView.accessoryDescription = nil
                delegate?.didEndSearch(textView)
            }
        }
        if currentSearch != nil {
            return !disallowedCharacters.contains(text)
        }
        return true
    }
}
