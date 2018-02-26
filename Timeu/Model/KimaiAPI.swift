//
//  KimaiAPI.swift
//  Timeu
//
//  Created by Sebastian Limbach on 03.10.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import Foundation

enum KimaiAPIResponseKeys: String, CodingKey {
    case result

    enum KimaiResultKeys: String, CodingKey {
        case success
        case items
    }
}

struct KimaiEntity<KimaiEntityItem> {
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

