//
//  TabBarItemView.swift
//  Timeu
//
//  Created by Sebastian Limbach on 13.02.2018.
//  Copyright © 2018 Sebastian Limbach. All rights reserved.
//

import UIKit
import ESTabBarController

class TabBarItemView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = .black
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = .black
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
