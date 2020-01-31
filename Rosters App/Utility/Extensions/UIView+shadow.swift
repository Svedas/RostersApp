//
//  UIView.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/17/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.cornerRadius = 4
        layer.borderWidth = 0.25

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //layer.shouldRasterize = true
        //layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
