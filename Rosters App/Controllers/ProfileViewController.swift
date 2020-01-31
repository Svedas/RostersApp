//
//  ProfileViewController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var player: Player?

    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var playerLabel: UILabel!
    @IBOutlet fileprivate weak var ageLabel: UILabel!
    @IBOutlet fileprivate weak var heightLabel: UILabel!
    @IBOutlet fileprivate weak var weightLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "ProfileVC"
        setPlayer()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        showLogo(named: "nba_logo.png")
//    }
}


extension ProfileViewController {
    private func setPlayer() {
        if let player = self.player {
            imageView.sizeToFit()
            let activityIndicator = self.imageView.setActivityIndicator()
            imageView.imageFromURL(urlString: player.icon
                ?? "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png", completionHandler: {
                    activityIndicator.removeFromSuperview()
            } )
            playerLabel.text = player.name
            ageLabel.text = "Age\n\(Date().getAgeFromDOF(date: player.age))"
            heightLabel.text = "Height\n\(formatText(text: player.height))"
            weightLabel.text = "Weight\n\(formatText(text: player.weight))"
            descriptionLabel.text = player.playerDescription
        }
    }
}

extension ProfileViewController {
    func formatText(text: String) -> String {
        if text.count > 4 {
            let fromIndex = text.index(after: text.firstIndex(of: "(") ?? text.startIndex)
            let toIndex =  text.index(before: text.endIndex)
            return String(text[fromIndex..<toIndex])
        } else {
            return text
        }
    }
}
