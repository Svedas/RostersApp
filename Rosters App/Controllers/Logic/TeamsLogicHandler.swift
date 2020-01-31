//
//  TeamsViewDataLoader.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/21/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

protocol TeamLoadable {
    func loadTeamData(then handler: @escaping (TeamsState) -> Void)
    
    var apiService: APIServiceProviding { get set }
    var coreDataService: DatabaseServiceManaging { get set }
    var userDefaultsService: UserDefaultsServiceManaging { get set }
}

class TeamsLogicHandler: TeamLoadable {
    typealias TeamHandler = (TeamsState) -> Void
    var teams: [Team] = []
    
    var apiService: APIServiceProviding // = APIService()
    var coreDataService: DatabaseServiceManaging // = RealmService()
    var userDefaultsService: UserDefaultsServiceManaging // = UserDefaultsSerivice()
    
    init(apiService: APIServiceProviding, coreDataService: DatabaseServiceManaging, userDefaultsService: UserDefaultsServiceManaging) {
        self.apiService = apiService
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
    }
    
    func loadTeamData(then handler: @escaping TeamHandler) {
        if !userDefaultsService.isUpdateTimeExists(forEntity: UpdateTime.Team) {
            getEverythingFromApiAndLoadInCoreData(withHandler: handler)
            return
        }
        
        if userDefaultsService.shouldUpdate(forEntity: UpdateTime.Team) {
            updateTeamsFromApiToCoreData(withHandler: handler)                          // Teams from API
        } else {
            getTeamsFromCoreData(withHandler: handler)                                  // Teams from Core
        }

        if userDefaultsService.shouldUpdate(forEntity: UpdateTime.Player) {
            updateEventsAndPlayersFromApiToCoreData(fromTeams: teams)                   // Events and Players from API
            return
        }

        if userDefaultsService.shouldUpdate(forEntity: UpdateTime.Event) {
            updateOnlyEventsFromApiToCoreData(fromTeams: teams)                         // Events from API
        }
    }
    
    // MARK: - Load teams from API and save into CoreData
    
    private func updateTeamsFromApiToCoreData(withHandler handler: @escaping TeamHandler) {
        getTeamsFromApi { handlerState in
            switch handlerState {
            case .loading:
                self.teams = []
            case .presenting(let teams):
                self.updateTeams(teams: teams)
                handler(.presenting(teams))
            case .failed(let error):
                handler(.failed(error))
            }
        }
        debugPrint("Teams Database reload")
    }
    
    private func getTeamsFromApi(withHandler handler: @escaping TeamHandler) {
        apiService.getAllTeams { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                self.teams = teams.teams ?? []
                handler(.presenting(self.teams))
            case .failure(let error):
                handler(.failed(error))
            }
        }
    }
    
    private func updateTeams(teams: [Team]) {
        coreDataService.createTeams(teams: teams)
        userDefaultsService.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Team)
    }
    
    // MARK: Load teams from core data
    
    private func getTeamsFromCoreData(withHandler handler: @escaping TeamHandler) {
        self.teams = coreDataService.retrieveTeams()
        handler(.presenting(self.teams))
        debugPrint("Teams load from Database")
    }
    
    // MARK: Load events and players from API and save into CoreData
    
    private func updateEventsAndPlayersFromApiToCoreData(fromTeams teams: [Team]) {
        for team in teams {
            updateEvents(fromTeam: team)
            updatePlayers(fromTeam: team)
        }
        debugPrint("Events and players Database reload")
    }
    
    private func updateOnlyEventsFromApiToCoreData(fromTeams teams: [Team]) {
        for team in teams {
            updateEvents(fromTeam: team)
        }
        debugPrint("Events Database reload")
    }
      
    // ##############################################
    
    private func updateEvents(fromTeam team: Team) {
        apiService.getTeamEvents(fromTeam: team ) { (result) in
            switch result {
            case .success(let events):
                self.saveEvents(fromTeam: team, events: events)
            case .failure( _):
                print("Error getting teams")
            }
        }
    }
    
    private func saveEvents(fromTeam team: Team, events: EventsResponse) {
        DispatchQueue.main.async {
            self.coreDataService.createEvents(events: events.results)
            self.userDefaultsService.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Event)
        }
    }
    
    // ##############################################
    
    private func updatePlayers(fromTeam team: Team) {
        apiService.getTeamPlayers(fromTeam: team) { (result) in
            switch result {
            case .success(let players):
                self.savePlayers(fromTeam: team, players: players)
            case .failure( _):
                print("Error getting teams")
            }
        }
    }
    
    private func savePlayers(fromTeam team: Team, players: PlayersResponse) {
        DispatchQueue.main.async {
            self.coreDataService.createPlayers(players: players.player)
            self.userDefaultsService.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Player)
        }
    }
    
    // MARK: First launch setup
    
    private func getEverythingFromApiAndLoadInCoreData(withHandler handler: @escaping TeamHandler) {
        apiService.getAllTeams { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                self.teams = teams.teams ?? []
                self.updateEverything(with: self.teams)
                handler(.presenting(self.teams))
            case .failure(let error):
                handler(.failed(error))
            }
        }
        debugPrint("First time lauch. Database load")
    }
    
    private func updateEverything(with teams: [Team]) {
        DispatchQueue.main.async {
            self.updateTeams(teams: self.teams)
            for team in teams {
                self.updateEvents(fromTeam: team)
                self.updatePlayers(fromTeam: team)
            }
        }
    }
}

