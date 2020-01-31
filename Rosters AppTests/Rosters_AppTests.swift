//
//  Rosters_AppTests.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/14/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest
@testable import Rosters_App

class Rosters_AppTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: ViewControllers
    
    func testTeamViewController() {
        var sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "teamsViewController") as? TeamsViewController
        XCTAssertNotNil(sut)
        sut = nil
    }
    
    func testSegmentedViewController() {
        var sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "segmentedViewController") as? SegmentedViewController
        XCTAssertNotNil(sut)
        sut = nil
    }
    
    func testNewsViewController() {
        var sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "newsViewController") as? NewsViewController
        XCTAssertNotNil(sut)
        sut = nil
    }
    
    func testPlayersViewController() {
        var sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "playersViewController") as? PlayersViewController
        XCTAssertNotNil(sut)
        sut = nil
    }
    
    // MARK: Models' inits
    
    func testEmptyLists() {
        // given
        let teams: [Team] = []
        let events: [Event] = []
        let players: [Player] = []
        // then
        XCTAssertEqual(teams.count, 0)
        XCTAssertEqual(events.count, 0)
        XCTAssertEqual(players.count, 0)
    }
    
    func testFilledLists() {
        // given
        var teams: [Team] = []
        var events: [Event] = []
        var players: [Player] = []
        // when
        teams.append(Team())
        teams.append(Team())
        teams.append(Team())
        events.append(Event())
        events.append(Event())
        players.append(Player())
        // then
        XCTAssertEqual(teams.count, 3)
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(players.count, 1)
    }
    
    // MARK: Text fromatting
    
    func testTextFormatter() {
        let sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "profileViewController") as? ProfileViewController
        let text = "6 ft 4 in (1.93 m)"
        let formattedText = sut?.formatText(text: text)
        XCTAssertEqual(formattedText, "1.93 m")
    }
    
    func testAgeFormatter() {
        let age = "1994-03-06"
        let formattedAge = Date().getAgeFromDOF(date: age)
        XCTAssertEqual(formattedAge, 25)
    }
}
