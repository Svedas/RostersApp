//
//  Logic_Controllers_Test.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest
@testable import Rosters_App


class Logic_Controllers_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Teams Logic controller (Not Unit Tests)
    
    func testFirstTeamLoadFromLogicController() {
        let logicController: TeamLoadable = TeamsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Teams")
        
        logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Team)
        logicController.loadTeamData { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                //print(teams.count)
                expectation.fulfill()
            default:
            print("")
            }
            
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Team)
        })
    }
    
    func testTeamsLoadFromLogicController() {
        let logicController: TeamLoadable = TeamsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Teams")
        
        logicController.userDefaultsService.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Team)
        logicController.loadTeamData { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                expectation.fulfill()
            default:
            print("")
            }
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Team)
        })
    }
    
    func testTeamsUpdateFromLogicController() {
        let logicController: TeamLoadable = TeamsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Teams")
        //expectation.isInverted = true
        guard let earlyDate = Calendar.current.date(byAdding: .hour, value: -2, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Team)
        logicController.loadTeamData { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                expectation.fulfill()
            default:
            print("")
            }
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Team)
        })
    }
    
    func testEventsUpdateFromLogicController() {
        let logicController: TeamLoadable = TeamsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Teams")
        //expectation.isInverted = true
        guard let earlyDateForTeams = Calendar.current.date(byAdding: .minute, value: -10, to: Date()) else { return  }
        guard let earlyDateForEvents = Calendar.current.date(byAdding: .minute, value: -20, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForTeams, forEntity: UpdateTime.Team)
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForEvents, forEntity: UpdateTime.Event)
        logicController.loadTeamData { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                expectation.fulfill()
            default:
            print("")
            }
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Team)
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Event)
        })
    }
    
    func testPlayersAndEventsUpdateFromLogicController() {
        let logicController: TeamLoadable = TeamsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Teams")
        //expectation.isInverted = true
        guard let earlyDateForTeams = Calendar.current.date(byAdding: .minute, value: -10, to: Date()) else { return  }
        guard let earlyDateForPlayers = Calendar.current.date(byAdding: .minute, value: -40, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForTeams, forEntity: UpdateTime.Team)
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForPlayers, forEntity: UpdateTime.Player)
        logicController.loadTeamData { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                //print(teams.count)
                expectation.fulfill()
            default:
            print("")
            }
            
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Team)
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Player)
        })
    }
    
    //############################################################
    
    func testLoadEmptyTeamEventsFromLogicController() {
        let logicController: EventLoadable = EventsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Events")

        let team = Team()
        guard let earlyDateForEvents = Calendar.current.date(byAdding: .minute, value: -10, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForEvents, forEntity: UpdateTime.Event)
        logicController.loadEventData(fromTeam: team) { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                //print(events.count)
                expectation.fulfill()
            default:
            print("")
            }
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Event)
        })
    }
    
    func testUpdateEmptyTeamEventsFromLogicController() {
        let logicController: EventLoadable = EventsLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Events")
        
        let team = Team()
        guard let earlyDateForEvents = Calendar.current.date(byAdding: .minute, value: -20, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForEvents, forEntity: UpdateTime.Event)
        logicController.loadEventData(fromTeam: team) { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                expectation.fulfill()
            default:
                print("")
            }
        }
        waitForExpectations(timeout: 2, handler: { _ in
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Event)
        })
    }
    
    func testLoadEmptyTeamPlayersFromLogicController() {
        let logicController: PlayerLoadable = PlayersLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Players")

        let team = Team()
        guard let earlyDateForPleyers = Calendar.current.date(byAdding: .minute, value: -10, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForPleyers, forEntity: UpdateTime.Player)
        logicController.loadPlayersData(fromTeam: team) { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                expectation.fulfill()
            default:
            print("")
            }
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Player)
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testUpdateEmptyTeamPlayersFromLogicController() {
        let logicController: PlayerLoadable = PlayersLogicHandler(apiService: MockAPIService(),
                                                                 coreDataService: MockCoreDataSercive(),
                                                                 userDefaultsService: MockUserDefaultsService())
        let expectation = self.expectation(description: "Load Players")

        let team = Team()
        guard let earlyDateForPleyers = Calendar.current.date(byAdding: .minute, value: -40, to: Date()) else { return  }
        logicController.userDefaultsService.setUpdateTime(withValue: earlyDateForPleyers, forEntity: UpdateTime.Player)
        logicController.loadPlayersData(fromTeam: team) { [weak self] state in
            guard self != nil else { return }
            switch state {
            case .presenting( _):
                expectation.fulfill()
            default:
                print("")
            }
            logicController.userDefaultsService.removeUpdateTime(forEntity: UpdateTime.Player)
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
