//
//  UserDefaultsPersistanceManager.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/21/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

enum UpdateTime: String {
    case Team   = "1"
    case Event  = "2"
    case Player = "3"
}

class UserDefaultsSerivice {
    private let defaults: UserDefaults
    
    init() {
        defaults = UserDefaults.standard
    }
}

extension UserDefaultsSerivice: UserDefaultsServiceManaging {
    func getUpdateTime(forEntity entity: UpdateTime) -> Date? {
        let date = self.defaults.object(forKey: entity.rawValue) as? Date
        return date
    }
    
    func setUpdateTime(withValue value: Date, forEntity entity: UpdateTime) {
        self.defaults.set(value, forKey: entity.rawValue)
    }
    
    func removeUpdateTime(forEntity entity: UpdateTime) {
        self.defaults.removeObject(forKey: entity.rawValue)
    }
    
    func isUpdateTimeExists(forEntity entity: UpdateTime) -> Bool {
        if (self.defaults.object(forKey: entity.rawValue) as? Date) != nil {
            return true
        } else {
            return false
        }
    }
    
    func shouldUpdate(forEntity entity: UpdateTime) -> Bool {
        guard let updateTime = self.getUpdateTime(forEntity: entity) else { return true }
        let timeInterval = Date().getMinutes(fromDate: updateTime )
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
        self.defaults.removeObject(forKey: UpdateTime.Team.rawValue)
        self.defaults.removeObject(forKey: UpdateTime.Event.rawValue)
        self.defaults.removeObject(forKey: UpdateTime.Player.rawValue)
    }
}
