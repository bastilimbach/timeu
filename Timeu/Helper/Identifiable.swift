//
//  ReusableIdentifier.swift
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

protocol Identifiable: class {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
