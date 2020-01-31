//
//  PlayersViewController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    var logicController: PlayerLoadable? // = PlayersLogicController()
    var refreshControl: UIRefreshControl?
    @IBOutlet private weak var playersTableView: UITableView!
    var team: Team?
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "PlayersVC"
        render(state: .presenting([]))
        logicController?.loadPlayersData(fromTeam: team ?? Team()) { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
        }
        addRefreshControl()
    }
}

extension PlayersViewController {
    private func render(state: PlayersState) {
        switch state {
            case .presenting(let players):
                self.players = players
                self.playersTableView.reloadData()
            
            case .failed(let error):
                self.players = []
                debugPrint(error)
        }
    }
    
    func addRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.blue
        self.refreshControl?.addTarget(self, action: #selector(refreshTeams), for: .valueChanged)
        self.playersTableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc func refreshTeams() {
        guard let earlyDate = Calendar.current.date(byAdding: .minute, value: -40, to: Date()) else { return  }
        let userDefaultsService = UserDefaultsSerivice()
        userDefaultsService.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Player)
        logicController?.loadPlayersData(fromTeam: team ?? Team()) { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
            self.refreshControl?.endRefreshing()
        }
        //self.teamCollectionView.reloadData()
    }
}

extension PlayersViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as? ProfileViewController
        
        guard let selectedPlayerCell = sender as? PlayerCell else { return }
        let indexPath = playersTableView.indexPath(for: selectedPlayerCell)
        let selectedPlayer = players[indexPath?.row ?? 0]
        
        nextViewController?.player = selectedPlayer
    }
}

extension PlayersViewController: UITableViewDataSource, UITableViewDelegate  { //TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let playerCell = tableView.dequeueReusableCell(withIdentifier: "playerCell",
                                                             for: indexPath) as? PlayerCell else { return UITableViewCell() }
        playerCell.setCell(name: players[indexPath.row].name, image: players[indexPath.row].icon)
        
        return playerCell
    }
}
