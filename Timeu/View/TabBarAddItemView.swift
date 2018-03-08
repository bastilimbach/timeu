//
//  TabBarAddItemView.swift
//  Timeu
//
//  Created by Sebastian Limbach on 12.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
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
        superview?.bringSubview(toFront: self)

        insets = UIEdgeInsetsMake(-22, 0, 0, 0)
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

    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("decreaseSize", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }

    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
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
