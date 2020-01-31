//
//  TeamResponse.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/20/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

struct TeamsResponse: Codable {
    let teams: [Team]?
}

struct EventsResponse: Codable {
    let results: [Event]?
}

struct PlayersResponse: Codable {
    let player: [Player]?
}
