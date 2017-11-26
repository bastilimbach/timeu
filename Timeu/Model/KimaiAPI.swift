//
//  KimaiAPI.swift
//  Timeu
//
//  Created by Sebastian Limbach on 03.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import Foundation

struct KimaiTimesheetResult: Codable {
    let result: KimaiResult

    struct KimaiResult: Codable {
        let success: Bool
        let items: [Activity]
    }

    struct Activity: Codable {
        let id: Int
        let description: String
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

}

extension KimaiTimesheetResult.Activity {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let description = try container.decode(String.self, forKey: .description)
        let customerName = try container.decode(String.self, forKey: .customerName)
        let projectName = try container.decode(String.self, forKey: .projectName)
        let startDateTime = try container.decode(String.self, forKey: .startDateTime)
        let endDateTime = try container.decode(String.self, forKey: .endDateTime)

        guard let decodedId = Int(id),
              let decodedStartDateTime = Double(startDateTime),
              let decodedEndDateTime = Double(endDateTime)
        else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Debug description"))
        }

        self.init(
            id: decodedId,
            description: description,
            customerName: customerName,
            projectName: projectName,
            startDateTime: Date(timeIntervalSince1970: decodedStartDateTime),
            endDateTime: Date(timeIntervalSince1970: decodedEndDateTime)
        )
    }

}
