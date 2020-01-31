//
//  TeamDescriptionCell.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/30/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class TeamDescriptionCell: UICollectionViewCell {
    
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var cellContentView: UIView! //
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowView.dropShadow()
    }
    
    func setCell(image: String, name: String, description: String) {
        self.shadowView.dropShadow()
        let activityIndicator = self.iconView.setActivityIndicator()
        self.iconView.imageFromURL(urlString: image, completionHandler: {
            activityIndicator.removeFromSuperview()
        })
        self.nameLabel.text = name
        self.descriptionLabel.text = description
    }
}
