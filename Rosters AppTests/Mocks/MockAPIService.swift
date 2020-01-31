//
//  MockAFSession.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/23/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
@testable import Rosters_App

class MockAPIService {
    
    var shouldReturnError = false
    var teamWasCalled = false
    var eventsWasCalled = false
    var playersWasCalled = false
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    convenience init() {
        self.init(shouldReturnError: false)
    }
    
    enum MockServiceError: Error {
        case noData
        case timedOut
    }
    
    func reset() {
        shouldReturnError = false
        teamWasCalled = false
        eventsWasCalled = false
        playersWasCalled = false
    }
    
    var teamResponse = """
    {
        "teams": [
            {
                "idTeam": "134880",
                "strTeam": "Atlanta Hawks",
                "strTeamShort": "ATL",
                "strStadiumThumb": "https://www.thesportsdb.com/images/media/team/stadium/qxstqs1420567922.jpg",
                "strDescriptionEN": "The Atlanta Hawks are an American professional basketball team based in Atlanta, Georgia.",
                "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/cfcn1w1503741986.png",
                "strTeamLogo": "https://www.thesportsdb.com/images/media/team/logo/3lyn5b1503742089.png"
            },
            {
                "idTeam": "134860",
                "strTeam": "Boston Celtics",
                "strStadiumThumb": "https://www.thesportsdb.com/images/media/team/stadium/yuyrvx1420576364.jpg",
                "strDescriptionEN": "The Boston Celtics are an American professional basketball franchise based in Boston, Massachusetts.",
                "strTeamBadge": "https://www.thesportsdb.com/images/media/team/badge/051sjd1537102179.png",
                "strTeamLogo": "https://www.thesportsdb.com/images/media/team/logo/xwuypy1420737149.png"
            }
        ]
    }
    """
    
    var eventsResponse = """
    {
        "results": [
            {
                "idEvent": "602363",
                "strEvent": "Wolves vs Liverpool",
                "strHomeTeam": "Wolves",
                "strAwayTeam": "Liverpool",
                "dateEvent": "2020-01-23",
                "idHomeTeam": "134880",
                "idAwayTeam": "133602"
            },
            {
                "idEvent": "602357",
                "strHomeTeam": "Liverpool",
                "strAwayTeam": "Man United",
                "dateEvent": "2020-01-19",
                "idHomeTeam": "134880",
                "idAwayTeam": "133612"
            }
        ]
    }
    """
    
    var playersResponse = """
    {
        "player": [
            {
                "idTeam": "134880",
                "strPlayer": "Marcus Smart",
                "dateBorn": "1994-03-06",
                "strDescriptionEN": "Marcus Osmond Smart (born March 6, 1994) is an American professional basketball player who currently plays for the Boston Celtics of the National Basketball Association (NBA).",
                "strHeight": "6 ft 4 in (1.93 m)",
                "strWeight": "220 lb (100 kg)",
                "strThumb": "https://www.thesportsdb.com/images/media/player/thumb/hsp6a01488110540.jpg"
            },
            {
                "idTeam": "134880",
                "strPlayer": "R.J. Hunter",
                "dateBorn": "1993-10-24",
                "strDescriptionEN": "Ronald Jordan R. J. Hunter (born October 24, 1993) is an American professional basketball player for the Long Island Nets of the NBA Development League.",
                "strHeight": "6 ft 5 in (1.96 m)",
                "strWeight": "185 lb (84 kg)",
                "strThumb": "https://www.thesportsdb.com/images/media/player/thumb/0j5mfk1549494415.jpg"
            }
        ]
    }
    """
    
}

extension MockAPIService: APIServiceProviding {
    func getAllTeams(completionHandler: @escaping (Result<TeamsResponse, Error>) -> Void) {
        teamWasCalled = true
        if shouldReturnError {
            completionHandler(.failure(MockServiceError.noData))
        } else {
            do {
                let data: Data? = teamResponse.data(using: .utf8)
                let teams = try JSONDecoder().decode(TeamsResponse.self, from: data ?? Data())
                completionHandler(.success(teams))
            } catch let jsonError {
                print(jsonError)
            }
        }
        reset()
    }
    
    func getTeamEvents(fromTeam team: Team, completionHandler: @escaping (Result<EventsResponse, Error>)  -> Void) {
        eventsWasCalled = true
        if shouldReturnError {
            completionHandler(.failure(MockServiceError.noData))
        } else {
            do {
                let data: Data? = eventsResponse.data(using: .utf8)
                let events = try JSONDecoder().decode(EventsResponse.self, from: data ?? Data())
                completionHandler(.success(events))
            } catch let jsonError {
                print(jsonError)
            }
        }
    }
    
    func getTeamPlayers(fromTeam team: Team, completionHandler: @escaping (Result<PlayersResponse, Error>)  -> Void) {
        playersWasCalled = true
        if shouldReturnError {
            completionHandler(.failure(MockServiceError.noData))
        } else {
            do {
                let data: Data? = playersResponse.data(using: .utf8)
                let players = try JSONDecoder().decode(PlayersResponse.self, from: data ?? Data())
                completionHandler(.success(players))
            } catch let jsonError {
                print(jsonError)
            }
        }
    }
}
