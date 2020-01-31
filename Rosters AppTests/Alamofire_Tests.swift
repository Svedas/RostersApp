//
//  Alamofire_Tests.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest
@testable import Rosters_App

class Alamofire_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Alamofire mocks
    
    func testGetTeamsWithAlamofire() {
        // Create an expectation
        let apiService = MockAPIService()
        
        let expectation = self.expectation(description: "Almofire Teams")
        var allTeams: [Team]?
        apiService.getAllTeams { (result) in
            switch result {
            case .success(let teams):
                allTeams = teams.teams
                //print(allTeams ?? "")
                if allTeams?.count == 2 { expectation.fulfill() }
            case .failure( _):
                print("Error getting teams")
            }
            
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(allTeams)
    }
    
    func testGetEventsWithAlamofire() {
        // Create an expectation
        let apiService = MockAPIService()
        
        let expectation = self.expectation(description: "Almofire Teams")
        var teamEvents: [Event]?
        let team = Team (id: "134880")
        
        apiService.getTeamEvents(fromTeam: team, completionHandler: { (result) in
            switch result {
            case .success(let events):
                teamEvents = events.results
                if teamEvents?.count == 2 { expectation.fulfill() }
            case .failure( _):
                print("Error getting teams")
            }
            
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(teamEvents)
    }
    
    func testGetPlayersWithAlamofire() {
        // Create an expectation
        let apiService = MockAPIService()
        
        let expectation = self.expectation(description: "Almofire Teams")
        var teamPlayers: [Player]?
        let team = Team (teamName: "Atlanta Hawks")
        
        apiService.getTeamPlayers(fromTeam: team, completionHandler: { (result) in
            switch result {
            case .success(let players):
                teamPlayers = players.player
                if teamPlayers?.count == 2 { expectation.fulfill() }
            case .failure( _):
                XCTFail()
            }
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(teamPlayers)
    }

}
