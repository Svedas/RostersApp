//
//  PlayerObject.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import RealmSwift

class PlayerObject: Object {
    @objc dynamic var teamID: String = "-1"
    @objc dynamic var icon: String = "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png"
    @objc dynamic var name: String = "Player_name"
    @objc dynamic var age: String = "??"
    @objc dynamic var height: String = "?? cm"
    @objc dynamic var weight: String = "?? kg"
    @objc dynamic var playerDescription: String = "Player_descriotion"
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
