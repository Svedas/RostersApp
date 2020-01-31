//
//  User_Defaults_Tests.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import XCTest
@testable import Rosters_App

class User_Defaults_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyUpdateTimes() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        sut.reset()
        let isEmptyTeam = sut.getUpdateTime(forEntity: UpdateTime.Team)
        let isEmptyEvent = sut.getUpdateTime(forEntity: UpdateTime.Team)
        let isEmptyPlayer = sut.getUpdateTime(forEntity: UpdateTime.Team)
        XCTAssertNil(isEmptyTeam)
        XCTAssertNil(isEmptyEvent)
        XCTAssertNil(isEmptyPlayer)
        sut.reset()
    }

    func testSetUpdateTime() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        sut.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Team)
        guard let date = sut.getUpdateTime(forEntity: UpdateTime.Team) else { return XCTFail() }
        let timeInterval = Date().getMinutes(fromDate: date )
        XCTAssertEqual(timeInterval, 0)
        sut.reset()
    }
    
    func testRemoveUpdateTime() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        sut.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Team)
        var isUpdateTime = sut.isUpdateTimeExists(forEntity: UpdateTime.Team)
        XCTAssertTrue(isUpdateTime)
        sut.removeUpdateTime(forEntity: UpdateTime.Team)
        isUpdateTime = sut.isUpdateTimeExists(forEntity: UpdateTime.Team)
        XCTAssertFalse(isUpdateTime)
        sut.reset()
    }
    
    func testShouldUpdateWhenFirstLaunch() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        sut.reset()
        let shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Team)
        XCTAssertTrue(shouldUpdate)
        sut.reset()
    }
    
    func testShouldUpdateTeams() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        
        sut.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Team)
        var shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Team)
        XCTAssertFalse(shouldUpdate)
        
        guard let earlyDate = Calendar.current.date(byAdding: .hour, value: -2, to: Date()) else { return  }
        sut.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Team)
        shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Team)
        XCTAssertTrue(shouldUpdate)
        sut.reset()
    }
    
    func testShouldUpdateEvents() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        
        sut.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Event)
        var shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Event)
        XCTAssertFalse(shouldUpdate)
        
        guard let earlyDate = Calendar.current.date(byAdding: .minute, value: -20, to: Date()) else { return  }
        sut.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Event)
        shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Event)
        XCTAssertTrue(shouldUpdate)
        sut.reset()
    }
    
    func testShouldUpdatePlayers() {
        let sut: UserDefaultsServiceManaging = UserDefaultsSerivice()
        
        sut.setUpdateTime(withValue: Date(), forEntity: UpdateTime.Player)
        var shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Player)
        XCTAssertFalse(shouldUpdate)
        
        guard let earlyDate = Calendar.current.date(byAdding: .minute, value: -40, to: Date()) else { return  }
        sut.setUpdateTime(withValue: earlyDate, forEntity: UpdateTime.Player)
        shouldUpdate = sut.shouldUpdate(forEntity: UpdateTime.Player)
        XCTAssertTrue(shouldUpdate)
        sut.reset()
    }

}
