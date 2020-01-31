//
//  RealmService.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/27/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealServiceProvider {
    func getRealm()
}

public class RealmService: DatabaseServiceManaging {
    
    private let teams: [TeamObject]
    
    init() {
        self.teams = []
    }
    private func getRealm() throws -> Realm {
        return try Realm()
    }
}

extension RealmService: TeamsPersisting {
    func createTeams(teams: [Team]?) {
        guard let teams = teams else { return }
        do {
            let realm = try getRealm()
            
            realm.beginWrite()
            for team in teams {
                realm.add(team.toRealmObject(), update: .all)
            }
            try realm.commitWrite()
        } catch let error {
            print(error)
        }
    }
    
    func retrieveTeams() -> [Team] {
        var teams: [Team] = []
        do {
            let realm = try getRealm()

            let teamsObjs = realm.objects(TeamObject.self)
            for teamObj in teamsObjs {
                teams.append(Team(fromRealmObject: teamObj))
            }
        } catch let error {
            print(error)
        }
        return teams
    }
    
    func deleteAllData(entity: String) {
        do {
            let realm = try getRealm()
            try realm.write {
                switch entity {
                case "Team":
                    let result = realm.objects(TeamObject.self)
                    realm.delete(result)
                case "Event":
                    let result = realm.objects(EventObject.self)
                    realm.delete(result)
                case "Player":
                    let result = realm.objects(PlayerObject.self)
                    realm.delete(result)
                default:
                    debugPrint("Bad Delete request")
                }
            }
        } catch let error {
            print(error)
        }
    }
}

extension RealmService: EventsPersisting {
    func createEvents(events: [Event]?) {
        guard let events = events else { return }
        do {
            let realm = try getRealm()
            
            realm.beginWrite()
            for event in events {
                realm.add(event.toRealmObject(), update: .modified)
            }
            try realm.commitWrite()
        } catch let error {
            print(error)
        }
    }
    
    func retrieveEvents(team: Team) -> [Event] {
        var events: [Event] = []
        do {
            let realm = try getRealm()
            
            let chekingHomeTeamPredicate = NSPredicate(format: "homeTeamID = %@", team.id)
            let checkingAwayTeamPredicate = NSPredicate(format: "awayTeamID = %@", team.id)
            let orPredicate = NSCompoundPredicate(type: .or, subpredicates: [chekingHomeTeamPredicate, checkingAwayTeamPredicate])
            let eventsObjs = realm.objects(EventObject.self).filter(orPredicate)
            
            for eventObj in eventsObjs {
                events.append(Event(fromRealmObject: eventObj))
            }
        } catch let error {
            print(error)
        }
        return events
    }
    
    func deleteAllEventDataWithTeamId(team: Team) {
        do {
            let realm = try getRealm()
            
            let chekingHomeTeamPredicate = NSPredicate(format: "homeTeamID = %@", team.id)
            let checkingAwayTeamPredicate = NSPredicate(format: "awayTeamID = %@", team.id)
            let orPredicate = NSCompoundPredicate(type: .or, subpredicates: [chekingHomeTeamPredicate, checkingAwayTeamPredicate])
            
            try realm.write {
                let result = realm.objects(EventObject.self).filter(orPredicate)
                realm.delete(result)
            }
        } catch let error {
            print(error)
        }
    }
}

extension RealmService: PlayersPersisting {
    func createPlayers(players: [Player]?) {
        guard let players = players else { return }
        do {
            let realm = try getRealm()
            
            realm.beginWrite()
            for player in players {
                realm.add(player.toRealmObject(), update: .all)
            }
            try realm.commitWrite()
        } catch let error {
            print(error)
        }
    }
    
    func retrievePlayers(team: Team) -> [Player] {
        var players: [Player] = []
        do {
            let realm = try getRealm()
            
            let predicate = NSPredicate(format: "teamID == %@", team.id)
            let playersObjs = realm.objects(PlayerObject.self).filter(predicate)
            
            for playerObj in playersObjs {
                players.append(Player(fromRealmObject: playerObj))
            }
        } catch let error {
            print(error)
        }
        return players
    }
    
    func deleteAllPlayerDataWithTeamId(team: Team) {
        do {
            let realm = try getRealm()
            
            let predicate = NSPredicate(format: "teamID == %@", team.id)
            
            try realm.write {
                let result = realm.objects(PlayerObject.self).filter(predicate)
                realm.delete(result)
            }
        } catch let error {
            print(error)
        }
    }
}
