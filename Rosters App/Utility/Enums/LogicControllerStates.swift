//
//  LogicControllerStates.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

enum TeamsState {
    case loading
    case presenting([Team])
    case failed(Error)
}

enum EventsState {
    case presenting([Event])
    case failed(Error)
}

enum PlayersState {
    case presenting([Player])
    case failed(Error)
}
