//
//  TabBarAddItemView.swift
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
import SnapKit
import ESTabBarController

class TabBarAddItemView: ESTabBarItemContentView {

    private let itemSize = CGSize(width: 50, height: 50)

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.backgroundColor = .timeuHighlight
        imageView.layer.cornerRadius = itemSize.height / 2
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.05
        imageView.layer.shadowOffset = CGSize(width: imageView.frame.width, height: imageView.frame.height + 5)
        imageView.layer.shadowRadius = 5
        imageView.contentMode = .center

        let transform = CGAffineTransform.identity
        imageView.transform = transform
        superview?.bringSubviewToFront(self)

        insets = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }

    override func updateLayout() {
        super.updateLayout()
        imageView.frame.size = itemSize
        imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }

    public override func highlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("decreaseSize", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }

    public override func dehighlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("resetSize", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
