//
//  SecondViewController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/8/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {
    @IBOutlet private weak var frontImageView: UIImageView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet private weak var newsContainerView: UIView!
    @IBOutlet private weak var playersContainerView: UIView!
    
    private var newsViewController: NewsViewController?
    private var playersViewController: PlayersViewController?

    @IBOutlet private weak var teamLabel: UILabel!
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "SegmentedVC"
        // Adding image from URL
        let activityIndicator = self.frontImageView.setActivityIndicator()
        frontImageView.imageFromURL(urlString: team?.photo ?? "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png", completionHandler: { activityIndicator.removeFromSuperview()  })
        teamLabel.text = team?.name
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        guard let newsContainerView = newsContainerView else { return }
        guard let playersContainerView = playersContainerView else { return }
        
        switch sender.selectedSegmentIndex {
        case 0:
            newsContainerView.alpha = 1
            playersContainerView.alpha = 0
        case 1:
            newsContainerView.alpha = 0
            playersContainerView.alpha = 1
        default:
            newsContainerView.alpha = 1
            playersContainerView.alpha = 0
        }
    }
}

extension SegmentedViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "newsIdentifier":
            guard let newsViewController = segue.destination as? NewsViewController else { return }
            newsViewController.team = self.team

        case "playersIdentifier":
            guard let playersViewController = segue.destination as? PlayersViewController else { return }
            playersViewController.team = self.team

        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Something unexpected happened")")
        }
    }
}
