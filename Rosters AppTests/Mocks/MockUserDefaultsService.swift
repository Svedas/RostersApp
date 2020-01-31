//
//  MockUserDefaultsService.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
@testable import Rosters_App

class MockUserDefaultsService {
    var teamTime: Date?
    var eventsTime: Date?
    var playersTime: Date?
}

extension MockUserDefaultsService: UserDefaultsServiceManaging {
    func getUpdateTime(forEntity entity: UpdateTime) -> Any? {
        switch entity {
        case .Team:
            return teamTime != nil ? teamTime : nil
        case .Event:
            return eventsTime != nil ? eventsTime : nil
        case .Player:
            return playersTime != nil ? playersTime : nil
        }
    }
    
    func setUpdateTime(withValue value: Date, forEntity entity: UpdateTime) {
        switch entity {
        case .Team:
            teamTime = value
        case .Event:
            eventsTime = value
        case .Player:
            playersTime = value
        }
    }
    
    func removeUpdateTime(forEntity entity: UpdateTime) {
        switch entity {
        case .Team:
            teamTime = nil
        case .Event:
            eventsTime = nil
        case .Player:
            playersTime = nil
        }
    }
    
    func isUpdateTimeExists(forEntity entity: UpdateTime) -> Bool {
        switch entity {
        case .Team:
            return teamTime != nil ? true : false
        case .Event:
            return eventsTime != nil ? true : false
        case .Player:
            return playersTime != nil ? true : false
        }
    }
    
    func shouldUpdate(forEntity entity: UpdateTime) -> Bool {
        guard let updateTime = self.getUpdateTime(forEntity: entity) else { return true }
        let timeInterval = Date().getMinutes(fromDate: updateTime)
        switch entity {
        case .Team:
            return timeInterval > 60 ? true : false
        case .Player:
            return timeInterval > 30 ? true : false
        case .Event:
            return timeInterval > 15 ? true : false
        }
    }
    
    func reset() {
        teamTime = nil
        eventsTime = nil
        playersTime = nil
    }
}
