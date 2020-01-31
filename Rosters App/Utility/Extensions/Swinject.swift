//
//  Swinject.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/30/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject
import SwinjectAutoregistration

extension SwinjectStoryboard {
    class func setup() {
        
        defaultContainer.register(APIServiceProviding.self) { _ in APIService() }
        defaultContainer.register(DatabaseServiceManaging.self) { _ in RealmService() }
        defaultContainer.register(UserDefaultsServiceManaging.self) { _ in UserDefaultsSerivice() }
        
        defaultContainer.storyboardInitCompleted(TeamsViewController.self) { (res, con) in
            con.logicController = res.resolve(TeamLoadable.self)
        }
        defaultContainer.autoregister(TeamLoadable.self, initializer: TeamsLogicHandler.init)
        
        
        defaultContainer.storyboardInitCompleted(NewsViewController.self) { (res, con) in
            con.logicController = res.resolve(EventLoadable.self)
        }
        defaultContainer.autoregister(EventLoadable.self, initializer: EventsLogicHandler.init)
        
        
        defaultContainer.storyboardInitCompleted(PlayersViewController.self) { (res, con) in
            con.logicController = res.resolve(PlayerLoadable.self)
        }
        defaultContainer.autoregister(PlayerLoadable.self, initializer: PlayersLogicHandler.init)
        
        // MARK: VC's withough Dependency injection
        
        defaultContainer.storyboardInitCompleted(UINavigationController.self, initCompleted: { _,_ in return })
        defaultContainer.storyboardInitCompleted(SegmentedViewController.self, initCompleted: { _,_ in return })
        defaultContainer.storyboardInitCompleted(ProfileViewController.self, initCompleted: { _,_ in return })
    }
}
