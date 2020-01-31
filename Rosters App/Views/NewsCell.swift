//
//  NewsCell.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var firstTeamLabel: UILabel!
    @IBOutlet private weak var secondTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setCell(date: String, leftTeam: String, rightTeam: String) {
        self.dateLabel.text = date
        self.firstTeamLabel.text = leftTeam
        self.secondTeamLabel.text = rightTeam
    }
}
