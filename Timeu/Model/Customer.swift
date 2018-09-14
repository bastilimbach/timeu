//
//  Customer.swift
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

struct Customer: Searchable {
    let customerId: Int
    let name: String
    let address: String?
    let visible: Int

    var searchableString: String {
        return name
    }

    enum CodingKeys: String, CodingKey {
        case customerId = "customerID"
        case address = "contact"
        case name, visible
    }
}

extension Customer: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        customerId = Int(try container.decode(String.self, forKey: .customerId))!
        name = try container.decode(String.self, forKey: .name)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        visible = Int(try container.decode(String.self, forKey: .visible))!
    }

}
