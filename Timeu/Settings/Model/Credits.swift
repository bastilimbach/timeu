//
//  Credits.swift
//  Timeu
//
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/).
//  All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

// swiftlint:disable line_length
import Foundation

struct Project {
    let name: String
    let author: String
    let website: URL?
}

struct Credits {
    static let oss = [
        Project(name: "SnapKit", author: "Robert Payne", website: URL(string: "https://github.com/SnapKit/SnapKit")),
        Project(name: "ESTabBarController", author: "Vincent Li", website: URL(string: "https://github.com/eggswift/ESTabBarController")),
        Project(name: "SwipeCellKit", author: "Jeremy Koch", website: URL(string: "https://github.com/SwipeCellKit/SwipeCellKit")),
        Project(name: "KeychainAccess", author: "Kishikawa Katsumi", website: URL(string: "https://github.com/kishikawakatsumi/KeychainAccess")),
        Project(name: "PasswordExtension", author: "Niklas Fahl", website: URL(string: "https://github.com/fahlout/PasswordExtension")),
        Project(name: "SwiftMessages", author: "Timothy Moose", website: URL(string: "https://github.com/SwiftKickMobile/SwiftMessages"))
    ]

    static let graphics = [
        Project(name: "Timesheet Icon", author: "Chunk Icons", website: URL(string: "https://thenounproject.com/term/time-card/597186")),
        Project(name: "Settings Icon", author: "Shmidt Sergey", website: URL(string: "https://thenounproject.com/term/settings/425479")),
        Project(name: "Delete Icon", author: "Lloyd Humphreys", website: URL(string: "https://thenounproject.com/term/delete/96634")),
        Project(name: "Duplicate Icon", author: "Popular", website: URL(string: "https://thenounproject.com/term/duplicate/1451436/")),
        Project(name: "Link Icon", author: "Krishna", website: URL(string: "https://thenounproject.com/term/url/1279492")),
        Project(name: "User Icon", author: "Saeed Farrahi", website: URL(string: "https://thenounproject.com/term/user/235726")),
        Project(name: "Unlock Icon", author: "Maxim Kulikov", website: URL(string: "https://thenounproject.com/term/unlock/829122")),
        Project(name: "Login Background Image", author: "Romello Williams", website: URL(string: "https://unsplash.com/photos/tnY6r0masQk"))
    ]
}
