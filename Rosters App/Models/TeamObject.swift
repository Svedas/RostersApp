//
//  TeamObject.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import RealmSwift

final class TeamObject: Object {
    @objc dynamic var id: String = "-"
    @objc dynamic var icon: String = "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png"
    @objc dynamic var photo: String = "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png"
    @objc dynamic var name: String = "Team_name"
    @objc dynamic var teamDescription: String = "Some_description"
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
