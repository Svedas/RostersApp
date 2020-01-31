//
//  PersistableProtocol.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmPersisting {
    associatedtype ManagedObject: RealmSwift.Object
    init(fromRealmObject: ManagedObject)
    func toRealmObject() -> ManagedObject
}
