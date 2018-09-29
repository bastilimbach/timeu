//
//  RecordTextView.swift
//  Timeu
// 	
//  Copyright © 2018 Sebastian Limbach (https://sebastianlimbach.com/). 
//  All rights reserved.	 
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//  

import UIKit

class RecordTextView: UITextView {

    var intrinsicContentHeight: CGFloat = 180

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        font = .systemFont(ofSize: 16, weight: .medium)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: intrinsicContentHeight)
    }

}
