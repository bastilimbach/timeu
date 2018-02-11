//
//  Extensions.swift
//  Timeu
//
//  Created by Sebastian Limbach on 28.09.2017.
//  Copyright © 2017 Sebastian Limbach. All rights reserved.
//

import UIKit

extension String {
    /// Returns the corresponding NSLocalizedString
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIColor {
    /// RGBA
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
