//
//  Team.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/9/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

struct Team: Codable {
    
    var id: String
    var icon: String
    var photo: String
    var name: String
    var teamDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case icon = "strTeamBadge"
        case photo = "strStadiumThumb"
        case name = "strTeam"
        case teamDescription = "strDescriptionEN"
    }
    
    init(id: String = "-",
         icon: String = "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png",
         photo: String = "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png",
         teamName: String = "Team_name",
         description: String = "Some_description") {
        self.id = id
        self.icon = icon
        self.photo = photo
        self.name = teamName
        self.teamDescription = description
    }
}


extension Team: RealmPersisting {
    public init(fromRealmObject realmObject: TeamObject) {
        self.id = realmObject.id
        self.icon = realmObject.icon
        self.photo = realmObject.photo
        self.name = realmObject.name
        self.teamDescription = realmObject.teamDescription
    }
    
    public func toRealmObject() -> TeamObject {
        let team = TeamObject()
        team.id = self.id
        team.icon = self.icon
        team.photo = self.photo
        team.name = self.name
        team.teamDescription = self.teamDescription
        return team
    }
}
