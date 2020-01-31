//
//  NewsViewController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    var logicController: EventLoadable? // = EventsLogicController()
    var refreshControl: UIRefreshControl?
    @IBOutlet private weak var newsTableView: UITableView!

    var team: Team?
    var events: [Event] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "NewsVC"
        render(state: .presenting([]))
        logicController?.loadEventData(fromTeam: team ?? Team()) { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
        }
        addRefreshControl()
    }
}

extension NewsViewController {
    private func render(state: EventsState){
        switch state {
            case .presenting(let events):
                self.events = events
                self.newsTableView.reloadData()
            
            case .failed(let error):
                self.events = []
                debugPrint(error)
        }
    }
    
    func addRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.blue
        self.refreshControl?.addTarget(self, action: #selector(refreshTeams), for: .valueChanged)
        self.newsTableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc func refreshTeams() {
        guard let earlyDate = Calendar.current.date(byAdding: .minute, value: -40, to: Date()) else { return  }
        let userDefaultsService = UserDefaultsSerivice()
        userDefaultsService.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Event)
        logicController?.loadEventData(fromTeam: team ?? Team()) { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
            self.refreshControl?.endRefreshing()
        }
        //self.teamCollectionView.reloadData()
    }
}

extension NewsViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count > 0 ? events.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell",
                                                           for: indexPath) as? NewsCell else { return UITableViewCell()}
        if events.count == 0 {
            newsCell.setCell(date: "-", leftTeam: "???", rightTeam: "???")
        } else {
            newsCell.setCell(date: events[indexPath.row].date,
                             leftTeam: events[indexPath.row].firstTeamName,
                             rightTeam: events[indexPath.row].secondTeamName)
        }
        return newsCell
    }
}
