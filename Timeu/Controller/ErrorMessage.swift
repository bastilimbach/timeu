//
//  ErrorMessage.swift
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
import SwiftMessages

class ErrorMessage {
    static func show(message: String, withTheme theme: Theme = .error) {
        var messageConfig = SwiftMessages.defaultConfig
        messageConfig.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: messageConfig) {
            let view = MessageView.viewFromNib(layout: .statusLine)
            view.configureTheme(theme, iconStyle: .subtle)
            view.button?.isHidden = true
            view.configureContent(title: "", body: message)
            return view
        }
    }
}
