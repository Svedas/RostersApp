//
//  ViewController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/8/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import UIKit
import CoreData

class TeamsViewController: UIViewController {
    var logicController: TeamLoadable? // = TeamsLogicController()
    var refreshControl: UIRefreshControl?
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet private weak var teamTableView: UITableView!
    private var vSpinner : UIView?
    private var teams: [Team] = [] {
        didSet {
            self.teamCollectionView.reloadData()
        }
    }
    var isEmpty = true
    var showingCell = 0 {
        didSet(newValue) {
            if showingCell != newValue { teamCollectionView.reloadData() }
            else { return }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "TeamsVC"
        render(state: .loading)
        logicController?.loadTeamData { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
        }
        addRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showLogo(named: "nba_logo.png")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as? SegmentedViewController
        guard let selectedTeamCell = sender as? UICollectionViewCell else { return }
        let indexPath = teamCollectionView.indexPath(for: selectedTeamCell)
        let selectedTeam = !isEmpty ? teams[indexPath?.row ?? 0] : Team()
        nextViewController?.team = selectedTeam
    }
    
    @IBAction func showTeamDescriptionsButton(_ sender: UIBarButtonItem) {
        showingCell = 1
    }
    
    @IBAction func showTeamsIconsButton(_ sender: UIBarButtonItem) {
        showingCell = 2
    }
}

extension TeamsViewController {
    private func render(state: TeamsState) {
        switch state {
            case .loading:
                self.teams = []
                vSpinner = self.showSpinner(onView: self.view)
            
            case .presenting(let teams):
                self.removeSpinner(vSpinner: vSpinner ?? UIView())
                self.teams = teams
                self.isEmpty = false
                if self.showingCell == 0 { self.showingCell = 1 }
            
            case .failed(let error):
                debugPrint(error)
                self.removeSpinner(vSpinner: vSpinner ?? UIView())
                self.teams = []
        }
    }
    
    func addRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.blue
        self.refreshControl?.addTarget(self, action: #selector(refreshTeams), for: .valueChanged)
        self.teamCollectionView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc func refreshTeams() {
        guard let earlyDate = Calendar.current.date(byAdding: .hour, value: -2, to: Date()) else { return  }
        let userDefaultsService = UserDefaultsSerivice()
        userDefaultsService.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Team)
        logicController?.loadTeamData { [weak self] state in
            guard let self = self else { return }
            self.render(state: state)
            self.refreshControl?.endRefreshing()
        }
    }
}

extension TeamsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count > 0 ? teams.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch showingCell {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell2",
                                                                for: indexPath) as? TeamDescriptionCell
            else { return TeamDescriptionCell() }
            
            isEmpty = true
            cell.setCell(image: "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png",
                         name: "No teams found",
                         description: "Please check your internet connection or reload the app")
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "collectionCell2",
                                                                 for: indexPath) as? TeamDescriptionCell
            else { return TeamDescriptionCell() }
    
            cell.setCell(image: teams[indexPath.row].icon,
                          name: teams[indexPath.row].name,
                          description: teams[indexPath.row].teamDescription)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell3",
                                                                for: indexPath) as? TeamIconCell
            else { return TeamIconCell()}
            cell.setCell(image: teams[indexPath.row].icon)
            return cell
        default:
            break
        }
        return TeamDescriptionCell()
    }
}
