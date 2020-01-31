//
//  UrlAgent.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/15/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    private let baseUrl: String
    
    init() {
        self.baseUrl = "https://www.thesportsdb.com/api/v1/json/1"
    }
}

extension APIService: APIServiceProviding {
    func getAllTeams(completionHandler: @escaping (Result<TeamsResponse, Error>) -> Void) {
        let path: String = "/lookup_all_teams.php/?id=4387"
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }
        
        AF.request(url).response { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completionHandler(.failure(APIServiceError.noData))
                    return
                }
                do {
                    let teams = try JSONDecoder().decode(TeamsResponse.self, from: data)
                    completionHandler(.success(teams))
                } catch let jsonError {
                    print(jsonError)
                    completionHandler(.failure(jsonError))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getTeamEvents(fromTeam team: Team, completionHandler: @escaping (Result<EventsResponse, Error>) -> Void) {
        let path: String = "/eventslast.php?id=\(team.id)"
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }
        
        AF.request(url).response { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completionHandler(.failure(APIServiceError.noData))
                    return
                }
                do {
                    let events = try JSONDecoder().decode(EventsResponse.self, from: data)
                    completionHandler(.success(events))
                } catch let jsonError {
                    print(jsonError)
                    completionHandler(.failure(jsonError))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getTeamPlayers(fromTeam team: Team, completionHandler: @escaping (Result<PlayersResponse, Error>) -> Void) {
        let fixedTeamName = team.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let path: String = "/searchplayers.php?t=\(fixedTeamName ?? "-1")"
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }
        
        AF.request(url).response { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completionHandler(.failure(APIServiceError.noData))
                    return
                }
                do {
                    let players = try JSONDecoder().decode(PlayersResponse.self, from: data)
                    completionHandler(.success(players))
                } catch let jsonError {
                    print(jsonError)
                    completionHandler(.failure(jsonError))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
