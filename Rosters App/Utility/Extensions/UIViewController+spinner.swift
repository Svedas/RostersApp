//
//  UIViewController+spinner.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/21/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showSpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func removeSpinner(vSpinner: UIView) {
        DispatchQueue.main.async {
            vSpinner.removeFromSuperview()
            //vSpinner = nil
        }
    }
}
