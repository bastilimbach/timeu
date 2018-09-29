//
//  Project.swift
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

struct Proj: Searchable {
    let projectId: Int
    let customerId: Int
    let name: String
    let comment: String?
    let visible: Int

    var searchableString: String {
        return name
    }

    enum CodingKeys: String, CodingKey {
        case projectId = "projectID"
        case customerId = "customerID"
        case name, comment, visible
    }
}

extension Proj: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        projectId = Int(try container.decode(String.self, forKey: .projectId))!
        customerId = Int(try container.decode(String.self, forKey: .customerId))!
        name = try container.decode(String.self, forKey: .name)
        comment = try container.decodeIfPresent(String.self, forKey: .comment)
        visible = Int(try container.decode(String.self, forKey: .visible))!
    }

}
