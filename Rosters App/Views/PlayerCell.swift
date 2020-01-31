//
//  PlayerCell.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    @IBOutlet private weak var playerLabel: UILabel!
    @IBOutlet private weak var playerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(name: String?, image: String?) {
        self.playerLabel.text = name
        let activityIndicator = self.imageView?.setActivityIndicator()
        self.playerImageView.imageFromURL(
            urlString: image ?? "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png",
            completionHandler: {
                activityIndicator?.removeFromSuperview()
        })
    }
}
