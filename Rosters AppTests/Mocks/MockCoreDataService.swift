//
//  MockCoreDataService.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
@testable import Rosters_App

class MockCoreDataSercive: DatabaseServiceManaging {
    let appDelegate = "Mock"
}

extension MockCoreDataSercive: TeamsPersisting {
    func createTeams(teams: [Team]?) {
        return
    }
    func retrieveTeams() -> [Team] {
        return []
    }
    func deleteAllData(entity: String) {
        return
    }
}

extension MockCoreDataSercive: EventsPersisting {
    func createEvents(events: [Event]?) {
        return
    }
    func retrieveEvents(team: Team) -> [Event] {
        return []
    }
    func deleteAllEventDataWithTeamId(team: Team) {
        return
    }
}

extension MockCoreDataSercive: PlayersPersisting {
    func createPlayers(players: [Player]?) {
        return
    }
    func retrievePlayers(team: Team) -> [Player] {
        return []
    }
    func deleteAllPlayerDataWithTeamId(team: Team) {
        return
    }
}
