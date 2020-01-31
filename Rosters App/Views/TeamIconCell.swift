//
//  TeamIconCell.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/30/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class TeamIconCell: UICollectionViewCell {
    @IBOutlet private weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(image: String) {
        let activityIndicator = self.iconView.setActivityIndicator()
        self.iconView.imageFromURL(urlString: image, completionHandler: {
            activityIndicator.removeFromSuperview()
        })
    }
}
