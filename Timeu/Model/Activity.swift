//
//  Activity.swift
//  Timeu
//
//  Created by Sebastian Limbach on 01.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import Foundation

struct Activity {
    let id: Int
    let description: String?
    let customerName: String
    let projectName: String
    let startDateTime: Date
    let endDateTime: Date

    enum CodingKeys: String, CodingKey {
        case id = "timeEntryID"
        case description
        case customerName
        case projectName
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
        startDateTime = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .startDateTime))!)
        endDateTime = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .endDateTime))!)
    }

}

