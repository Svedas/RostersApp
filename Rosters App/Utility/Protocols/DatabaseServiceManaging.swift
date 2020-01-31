//
//  DatabaseServiceProtocol.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation


protocol DatabaseServiceManaging: TeamsPersisting, EventsPersisting, PlayersPersisting {
    // Composing protocols
}

protocol TeamsPersisting {
    func createTeams(teams: [Team]?)
    func retrieveTeams() -> [Team]
    func deleteAllData(entity: String)
}

protocol EventsPersisting {
    func createEvents(events: [Event]?)
    func retrieveEvents(team: Team) -> [Event]
    func deleteAllEventDataWithTeamId(team: Team)
}

protocol PlayersPersisting {
    func createPlayers(players: [Player]?)
    func retrievePlayers(team: Team) -> [Player]
    func deleteAllPlayerDataWithTeamId(team: Team)
}
