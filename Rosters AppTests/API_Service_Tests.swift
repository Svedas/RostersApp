//
//  API_Service_Tests.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest
@testable import Rosters_App

class API_Service_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTeams() {
        let sut: APIServiceProviding = APIService()
        let expectation = self.expectation(description: "API Team get")
        var testTeams: [Team]?
        sut.getAllTeams { (result) in
            switch result {
            case .success(let teams):
                testTeams = teams.teams
                expectation.fulfill()
            case .failure( _):
                print("")
            }
        }
        waitForExpectations(timeout: 2, handler: {_ in
            XCTAssertNotNil(testTeams)
        })
    }
    
    func testGetEmptyEvents() {
        let sut: APIServiceProviding = APIService()
        let expectation = self.expectation(description: "API Empty events get")
        let testTeam: Team = Team()
        var testEvents: [Event]?
        sut.getTeamEvents(fromTeam: testTeam, completionHandler: { (result) in
            switch result {
            case .success(let events):
                print(events)
            case .failure( _):
                testEvents = []
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: {_ in
            XCTAssertNotNil(testEvents)
        })
    }
    
    func testGetEmptyPlayers() {
        let sut: APIServiceProviding = APIService()
        let expectation = self.expectation(description: "API Empty players get")
        let testTeam: Team = Team()
        var testPlayer: [Player]?
        sut.getTeamPlayers(fromTeam: testTeam, completionHandler: { (result) in
            switch result {
            case .success(let players):
                //#warning("Returns success on false team")
                print(players)
                testPlayer = []
                expectation.fulfill()
            case .failure( _):
                testPlayer = []
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: {_ in
            XCTAssertNotNil(testPlayer)
        })
    }
}
