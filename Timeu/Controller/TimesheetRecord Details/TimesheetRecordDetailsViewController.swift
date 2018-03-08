//
//  TimesheetRecordDetailsViewController.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
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

        view.detailsCardView.day = DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: timesheetRecord.startDateTime) - 1]
        view.detailsCardView.task = timesheetRecord.task
        view.detailsCardView.customer = timesheetRecord.customerName
        view.detailsCardView.project = timesheetRecord.projectName
        view.detailsCardView.startEndTimeView.startTimeLabel.text = shortTimeFormatter.string(from: timesheetRecord.startDateTime)
        view.detailsCardView.startEndTimeView.startDateLabel.text = mediumDateFormatter.string(from: timesheetRecord.startDateTime)
        view.detailsCardView.startEndTimeView.endTimeLabel.text = shortTimeFormatter.string(from: timesheetRecord.endDateTime)
        view.detailsCardView.startEndTimeView.endDateLabel.text = mediumDateFormatter.string(from: timesheetRecord.endDateTime)
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
        navigationItem.title = "\("WeekOfTheYear".localized()) \(Calendar.current.component(.weekOfYear, from: timesheetRecord.startDateTime))"
    }

}
