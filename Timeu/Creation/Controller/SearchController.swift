//
//  SearchController.swift
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

class SearchController: UIViewController {

    var results = [Searchable]() {
        didSet {
            tableView.reloadData()
        }
    }
    private let tableView = SearchTableView()
    private(set) var filteredResults = [Searchable]()
    var selectionHandler: ((Searchable) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func search(_ searchString: String) {
        filteredResults = results.filter({
            $0.searchableString.range(of: searchString, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }

}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.isEmpty ? results.count : filteredResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier,
                                                       for: indexPath)
            as? SearchTableViewCell else { return UITableViewCell() }
        if filteredResults.isEmpty {
            cell.configure(object: results[indexPath.row])
        } else {
            cell.configure(object: filteredResults[indexPath.row])
        }
        return cell
    }
}

extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredResults.isEmpty {
            selectionHandler?(results[indexPath.row])
        } else {
            selectionHandler?(filteredResults[indexPath.row])
        }
    }
}
