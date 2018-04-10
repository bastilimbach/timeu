//
//  KimaiAPI.swift
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

enum KimaiAPIResponseKeys: String, CodingKey {
    case result

    enum KimaiResultKeys: String, CodingKey {
        case success
        case items
    }
}

struct KimaiEntity<KimaiEntityItem: Decodable> {
    let success: Bool
    let items: [KimaiEntityItem]
}

extension KimaiEntity: Decodable {

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: KimaiAPIResponseKeys.self)
        let resultContainer = try rootContainer.nestedContainer(keyedBy: KimaiAPIResponseKeys.KimaiResultKeys.self, forKey: .result)
        success = try resultContainer.decode(Bool.self, forKey: .success)
        items = try resultContainer.decode([KimaiEntityItem].self, forKey: .items)
    }

}

struct APIKey: Codable {
    let apiKey: String
}

struct KimaiAPIMetadata: Codable {
    let transport: String
    let envelope: String
    let contentType: String
    let SMDVersion: String
    let target: String
}

