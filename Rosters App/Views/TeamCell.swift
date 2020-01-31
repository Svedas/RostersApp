//
//  TeamCell.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/8/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var cellContentView: UIView! //
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
