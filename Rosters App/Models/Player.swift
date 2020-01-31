//
//  Player.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit

struct Player: Codable {
    
    var teamID: String
    var icon: String?
    var name: String
    var age: String
    var height: String
    var weight: String
    var playerDescription: String?
    
    private enum CodingKeys: String, CodingKey {
        case teamID = "idTeam"
        case icon = "strThumb"
        case name = "strPlayer"
        case age = "dateBorn"
        case height = "strHeight"
        case weight = "strWeight"
        case playerDescription = "strDescriptionEN"
    }
    
    init(teamID: String = "-1",
         icon: String = "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png",
         name: String = "Player_name",
         age: String = "??",
         height: String = "?? cm",
         weight: String = "?? kg",
         description: String = "Player_descriotion") {
        self.teamID = teamID
        self.icon = icon
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.playerDescription = description
    }
}


extension Player: RealmPersisting {
    public init(fromRealmObject realmObject: PlayerObject) {
        self.teamID = realmObject.teamID
        self.icon = realmObject.icon
        self.name = realmObject.name
        self.age = realmObject.age
        self.height = realmObject.height
        self.weight = realmObject.weight
        self.playerDescription = realmObject.playerDescription
    }
    
    public func toRealmObject() -> PlayerObject {
        let player = PlayerObject()
        player.teamID = self.teamID
        player.icon = self.icon ?? "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png"
        player.name = self.name
        player.age = self.age
        player.height = self.height
        player.weight = self.weight
        player.playerDescription = self.playerDescription ?? ""
        return player
    }
}
