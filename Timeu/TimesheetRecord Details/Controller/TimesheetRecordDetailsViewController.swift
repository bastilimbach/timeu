//
//  TimesheetRecordDetailsViewController.swift
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

class TimesheetRecordDetailsViewController: UIViewController {

    let timesheetRecord: Activity

    lazy var detailsView: TimesheetRecordDetailsView = {
        let view = TimesheetRecordDetailsView()
        let mediumDateFormatter = DateFormatter()
        mediumDateFormatter.dateStyle = .medium
        mediumDateFormatter.timeStyle = .none

        let shortTimeFormatter = DateFormatter()
        shortTimeFormatter.dateStyle = .none
        shortTimeFormatter.timeStyle = .short

        view.detailsCardView.day = DateFormatter().weekdaySymbols[
            Calendar.current.component(.weekday, from: timesheetRecord.startDateTime) - 1
        ]
        view.detailsCardView.task = timesheetRecord.task
        view.detailsCardView.customer = timesheetRecord.customerName
        view.detailsCardView.project = timesheetRecord.projectName
        view.detailsCardView.startEndTimeView.startTimeLabel.text = shortTimeFormatter.string(
            from: timesheetRecord.startDateTime)
        view.detailsCardView.startEndTimeView.startDateLabel.text = mediumDateFormatter.string(
            from: timesheetRecord.startDateTime)
        view.detailsCardView.startEndTimeView.endTimeLabel.text = shortTimeFormatter.string(
            from: timesheetRecord.endDateTime)
        view.detailsCardView.startEndTimeView.endDateLabel.text = mediumDateFormatter.string(
            from: timesheetRecord.endDateTime)
        view.descriptionText = timesheetRecord.description
        return view
    }()

    init(forRecord record: Activity) {
        self.timesheetRecord = record
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailsView
        navigationItem.largeTitleDisplayMode = .never
        let calendarWeek = Calendar.current.component(.weekOfYear, from: timesheetRecord.startDateTime)
        navigationItem.title = """
            \("timesheetRecordDetail.navigationTitle".localized()) \(calendarWeek)
            """
    }

}
