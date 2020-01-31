//
//  MockPersistanceManager.swift
//  Rosters AppTests
//
//  Created by Mantas Svedas on 1/24/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
@testable import Rosters_App

class MockPersistanceManager {
    
    var teamUpdateTime = Date()
    var eventUpdateTime = Date()
    var playerUpdateTime = Date()
    
    func reset() {
        teamUpdateTime = Date()
        eventUpdateTime = Date()
        playerUpdateTime = Date()
    }
    
    func setTeamUpdateTime(date: Date) {
        teamUpdateTime = date
    }
    func setEventUpdateTime(date: Date) {
        eventUpdateTime = date
    }
    func setPlayerUpdateTime(date: Date) {
        playerUpdateTime = date
    }
}

extension MockPersistanceManager: PersistanceManagerProtocol {
    func getUpdateTime(forKey key: String) -> Any? {
        <#code#>
    }
    
    func setUpdateTime(withValue value: Date, forKey key: String) {
        <#code#>
    }
    
    func removeUpdateTime(forKey key: String) {
        <#code#>
    }
}
