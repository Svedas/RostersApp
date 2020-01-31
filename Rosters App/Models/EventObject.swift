//
//  EventObject.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import RealmSwift

final class EventObject: Object {
    @objc dynamic var eventID: String = "-1"
    @objc dynamic var homeTeamID: String = "-10"
    @objc dynamic var awayTeamID: String = "-01"
    @objc dynamic var date: String = "????-??-??"
    @objc dynamic var firstTeamName: String = "Team_one"
    @objc dynamic var secondTeamName: String = "Team_two"
    
    override static func primaryKey() -> String? {
        return "eventID"
    }
}
