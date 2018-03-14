//
//  Activity.swift
//  Timeu
//
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/).
//  All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation

struct Activity {
    let id: Int
    let description: String?
    let customerName: String
    let projectName: String
    let task: String
    let startDateTime: Date
    let endDateTime: Date

    enum CodingKeys: String, CodingKey {
        case id = "timeEntryID"
        case description
        case customerName
        case projectName
        case task = "activityName"
        case startDateTime = "start"
        case endDateTime = "end"
    }
}

extension Activity: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Int(try container.decode(String.self, forKey: .id))!
        description = try container.decodeIfPresent(String.self, forKey: .description)
        customerName = try container.decode(String.self, forKey: .customerName)
        projectName = try container.decode(String.self, forKey: .projectName)
        task = try container.decode(String.self, forKey: .task)
        startDateTime = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .startDateTime))!)
        endDateTime = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .endDateTime))!)
    }

}

