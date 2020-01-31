//
//  UserDefaultsServiceProtocol.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

protocol UserDefaultsServiceManaging {
    func getUpdateTime(forEntity entity: UpdateTime) -> Date?
    func setUpdateTime(withValue value: Date, forEntity entity: UpdateTime)
    func removeUpdateTime(forEntity entity: UpdateTime)
    func isUpdateTimeExists(forEntity entity: UpdateTime) -> Bool
    func shouldUpdate(forEntity entity: UpdateTime) -> Bool
    func reset()
}
