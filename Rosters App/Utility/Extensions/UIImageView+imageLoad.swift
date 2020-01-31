//
//  UIImageView.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/17/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String, completionHandler handler: @escaping () -> Void ) {
 
        guard let url = NSURL(string: urlString) as URL? else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            guard let data = data else {
                print("No Data")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data)
                self.image = image
            })
        }).resume()
    }
    
    public func setActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
         
        if self.image == nil {
         self.addSubview(activityIndicator)
        }
        return activityIndicator
    }
}
