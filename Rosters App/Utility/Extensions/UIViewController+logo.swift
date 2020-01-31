//
//  NavigationItem+logo.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/30/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showLogo(named name: String) {
        let logo = UIImage(named: name)
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}
