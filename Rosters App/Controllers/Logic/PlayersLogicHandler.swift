//
//  PlayersLogicController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/21/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

protocol PlayerLoadable {
    func loadPlayersData(fromTeam team: Team, handler: @escaping (PlayersState) -> Void)
    
    var apiService: APIServiceProviding { get set }
    var coreDataService: DatabaseServiceManaging { get set }
    var userDefaultsService: UserDefaultsServiceManaging { get set }
}

class PlayersLogicHandler: PlayerLoadable {
    typealias PlayerHandler = (PlayersState) -> Void
    var players: [Player] = []
    
    var apiService: APIServiceProviding // = APIService()
    var coreDataService: DatabaseServiceManaging // = RealmService()
    var userDefaultsService: UserDefaultsServiceManaging // = UserDefaultsSerivice()
    
    init(apiService: APIServiceProviding, coreDataService: DatabaseServiceManaging, userDefaultsService: UserDefaultsServiceManaging) {
        self.apiService = apiService
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
    }
    
    func loadPlayersData(fromTeam team: Team, handler: @escaping PlayerHandler) {
        if !userDefaultsService.isUpdateTimeExists(forEntity: UpdateTime.Player) {
            debugPrint("Very bad. Events should have been created")
            handler(.failed(UserDefaultsError.notInitialized))
        }
        
        if userDefaultsService.shouldUpdate(forEntity: UpdateTime.Player) {
            updateTeamEventsFromApiIntoCoreData(fromTeam: team, withHandler: handler)
        } else {
            getTeamPlayersFromCoreData(fromTeam: team, withHandler: handler)
        }
    }
    
    // MARK: Helper functions
    
    private func updateTeamEventsFromApiIntoCoreData(fromTeam team: Team, withHandler handler: @escaping PlayerHandler) {
        getPlayersFromApi(fromTeam: team, withHandler: { handlerState in
            switch handlerState {
            case .presenting(let players):
                DispatchQueue.main.async { self.coreDataService.createPlayers(players: players) }
                handler(.presenting(players))
            case .failed(let error):
                handler(.failed(error))
            }
        })
        debugPrint("Players for \(team.name ) Loading from API")
    }
    
    private func getPlayersFromApi(fromTeam team: Team, withHandler handler: @escaping PlayerHandler) {
        apiService.getTeamPlayers(fromTeam: team ) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let players):
                self.players = players.player ?? []
                handler(.presenting(self.players))
            case .failure(let error):
                print("Error getting teams")
                handler(.failed(error))
            }
        }
    }
    
    private func getTeamPlayersFromCoreData(fromTeam team: Team, withHandler handler: @escaping PlayerHandler) {
        self.players = coreDataService.retrievePlayers(team: team )
        handler(.presenting(players))
        debugPrint("Players for \(team.name ) Loading from Database")
    }
}

