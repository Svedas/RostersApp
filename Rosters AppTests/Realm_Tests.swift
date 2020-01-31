//
//  Realm_Tests.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/29/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest
@testable import Rosters_App

class Realm_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyTeams() {
        let sut: DatabaseServiceManaging = RealmService()
        sut.deleteAllData(entity: "Team")
        sut.deleteAllData(entity: "Event")
        sut.deleteAllData(entity: "Player")
        let teams: [Team] = sut.retrieveTeams()
        XCTAssertEqual(teams.count, 0)
    }
    
    func testCreateTeam() {
        let sut: DatabaseServiceManaging = RealmService()
        let newTeam = Team(id: "12345")
        sut.deleteAllData(entity: "Team")
        sut.createTeams(teams: [newTeam])
        
        let teams = sut.retrieveTeams()
        XCTAssertEqual(newTeam.id, teams[0].id)
    }
    
    func testCreateEvent() {
        let sut: DatabaseServiceManaging = RealmService()
        let team = Team(id: "12345")
        let newEvent = Event(homeTeamID: "12345")
        sut.deleteAllEventDataWithTeamId(team: team)
        //sut.deleteAllData(entity: "Event")
        sut.createEvents(events: [newEvent])
        
        let events = sut.retrieveEvents(team: team)
        XCTAssertEqual(newEvent.eventID, events[0].eventID)
    }
    
    func testCreatePlayer() {
        let sut: DatabaseServiceManaging = RealmService()
        let team = Team(id: "12345")
        let newPlayer = Player(teamID: "12345")
        sut.deleteAllPlayerDataWithTeamId(team: team)
        //sut.deleteAllData(entity: "Player")
        sut.createPlayers(players: [newPlayer])
        
        let players = sut.retrievePlayers(team: team)
        XCTAssertEqual(newPlayer.teamID, players[0].teamID)
    }
    
}
