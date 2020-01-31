//
//  ApiProtocol.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

protocol APIServiceProviding {
    func getAllTeams(completionHandler: @escaping (Result<TeamsResponse, Error>) -> Void)
    func getTeamEvents(fromTeam team: Team, completionHandler: @escaping (Result<EventsResponse, Error>) -> Void)
    func getTeamPlayers(fromTeam team: Team, completionHandler: @escaping (Result<PlayersResponse, Error>) -> Void)
}
