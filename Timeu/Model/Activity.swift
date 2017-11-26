//
//  Activity.swift
//  Timeu
//
//  Created by Sebastian Limbach on 01.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import Foundation

struct Activity: Codable {
    let id: Int
    let description: String
    let customerName: String
    let projectName: String
    let startDateTime: Date
    let endDateTime: Date
}

extension Activity {
    init(from source: KimaiTimesheetResult.Activity) {
        self.id = source.id
        self.description = source.description
        self.customerName = source.customerName
        self.projectName = source.projectName
        self.startDateTime = source.startDateTime
        self.endDateTime = source.endDateTime
    }
}
