//
//  EventsLogicController.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/21/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

protocol EventLoadable {
    func loadEventData(fromTeam team: Team, handler: @escaping (EventsState) -> Void)
    
    var apiService: APIServiceProviding { get set }
    var coreDataService: DatabaseServiceManaging { get set }
    var userDefaultsService: UserDefaultsServiceManaging { get set }
}

class EventsLogicHandler: EventLoadable {
    typealias EventHandler = (EventsState) -> Void
    var events: [Event] = []
    
    var apiService: APIServiceProviding // = APIService()
    var coreDataService: DatabaseServiceManaging // = RealmService()
    var userDefaultsService: UserDefaultsServiceManaging // = UserDefaultsSerivice()
    
    init(apiService: APIServiceProviding, coreDataService: DatabaseServiceManaging, userDefaultsService: UserDefaultsServiceManaging) {
        self.apiService = apiService
        self.coreDataService = coreDataService
        self.userDefaultsService = userDefaultsService
    }
    
    func loadEventData(fromTeam team: Team, handler: @escaping EventHandler) {
        if !userDefaultsService.isUpdateTimeExists(forEntity: UpdateTime.Event) {
            debugPrint("Very bad. Events should have been created")
            handler(.failed(UserDefaultsError.notInitialized))
        }
        
        if userDefaultsService.shouldUpdate(forEntity: UpdateTime.Event)  {
            updateTeamEventsFromApiIntoCoreData(fromTeam: team, withHandler: handler)
        } else {
            getTeamEventsFromCoreData(fromTeam: team, withHandler: handler)
        }
    }
    
    // MARK: Helper functions
    
    private func updateTeamEventsFromApiIntoCoreData(fromTeam team: Team, withHandler handler: @escaping EventHandler) {
        getTeamEventsFromApi(fromTeam: team, withHandler: { handlerState in
            switch handlerState {
            case .presenting(let events):
                DispatchQueue.main.async { self.coreDataService.createEvents(events: events) }
                handler(.presenting(events))
            case .failed(let error):
                handler(.failed(error))
            }
        })
        debugPrint("Events for \(team.name ) Loading from API")
    }
    
    private func getTeamEventsFromApi(fromTeam team: Team, withHandler handler: @escaping EventHandler) {
        apiService.getTeamEvents(fromTeam: team ) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.events = events.results ?? []
                handler(.presenting(self.events))
            case .failure(let error):
                print("Error getting teams")
                handler(.failed(error))
            }
        }
    }
    
    private func getTeamEventsFromCoreData(fromTeam team: Team, withHandler handler: @escaping EventHandler) {
        self.events = coreDataService.retrieveEvents(team: team )
        handler(.presenting(events))
        debugPrint("Events for \(team.name ) Loading from Database")
    }
}

