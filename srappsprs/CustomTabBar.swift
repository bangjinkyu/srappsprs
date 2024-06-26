//
//  CustomTabBar.swift
//  srappsprs
//
//  Created by 방진규 on 2023/10/31.
//

import Foundation
import UIKit


class CustomTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 20
        return sizeThatFits
    }
}
