//
//  Event.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit

struct Event: Codable {
    
    var eventID: String
    var homeTeamID: String
    var awayTeamID: String
    var date: String
    var firstTeamName: String
    var secondTeamName: String
    
    private enum CodingKeys: String, CodingKey {
        case eventID = "idEvent"
        case homeTeamID = "idHomeTeam"
        case awayTeamID = "idAwayTeam"
        case date = "dateEvent"
        case firstTeamName = "strAwayTeam"
        case secondTeamName = "strHomeTeam"
    }
    
    init(eventID: String = "-1",
         homeTeamID: String = "-10",
         awayTeamID: String = "-01",
         date: String = "????-??-??",
         firstTeam: String = "Team_one",
         secondTeam: String = "Team_two") {
        self.eventID = eventID
        self.homeTeamID = homeTeamID
        self.awayTeamID = awayTeamID
        self.date = date
        self.firstTeamName = firstTeam
        self.secondTeamName = secondTeam
    }
}


extension Event: RealmPersisting {
    public init(fromRealmObject realmObject: EventObject) {
        self.eventID = realmObject.eventID
        self.homeTeamID = realmObject.homeTeamID
        self.awayTeamID = realmObject.awayTeamID
        self.date = realmObject.date
        self.firstTeamName = realmObject.firstTeamName
        self.secondTeamName = realmObject.secondTeamName
    }
    public func toRealmObject() -> EventObject {
        let event = EventObject()
        event.eventID = self.eventID
        event.homeTeamID = self.homeTeamID
        event.awayTeamID = self.awayTeamID
        event.date = self.date
        event.firstTeamName = self.firstTeamName
        event.secondTeamName = self.secondTeamName
        return event
    }
}
