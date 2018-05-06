//
//  TimeuUITests.swift
//  Timeu
// 	
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/). 
//  All rights reserved.	 
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//  

import XCTest

class TimeuUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["UI-Testing"]
        setupSnapshot(app)
        app.launch()
    }

    func testUIToGenerateScreenshots() {
        snapshot("LoginView")

        let scrollViewsButtons = app.scrollViews.buttons
        scrollViewsButtons.matching(identifier: "demoButton").element.tap()
        scrollViewsButtons.matching(identifier: "loginButton").element.tap()
        snapshot("TimesheetView")

        let tableViewCells = app.tables.cells
        tableViewCells.matching(identifier: "timesheetCell_1_0").element.tap()
        snapshot("RecordDetailsView")
    }

    override func tearDown() {
        app.launchArguments.removeAll()
        super.tearDown()
    }

}
