////
////  CoreDataController.swift
////  Rosters App
////
////  Created by Mantas Svedas on 1/17/20.
////  Copyright © 2020 Mantas Svedas. All rights reserved.
////
//
//import UIKit
//import Foundation
//import CoreData
//
//class CoreDataService: DatabaseServiceProtocol {
//
//    // MARK: Creation
//
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//    private func fetchAndDeleteObjects(forContext context: NSManagedObjectContext, withRequest request: NSFetchRequest<NSFetchRequestResult>) {
//        do
//        {
//            let results = try context.fetch(request)
//            for managedObject in results
//            {
//                guard let managedObjectData:NSManagedObject = managedObject as? NSManagedObject else { return }
//                context.delete(managedObjectData)
//            }
//            do {
//               try context.save()
//              } catch {
//               print("Failed saving")
//            }
//        } catch let error as NSError {
//            print("Delete data. error : \(error) \(error.userInfo)")
//        }
//    }
//}
//
//    // MARK: Teams
//
//extension CoreDataService: TeamsPersistable {
//    func createTeams(teams: [Team]?) {
//        let context = appDelegate.persistentContainer.viewContext
//
//        guard let teams = teams else { return }
//        for team in teams {
//            if !isEntityWithKeyExists(entity: "TeamData", format: "id", key: team.id) {
//                let teamData = TeamData(entity: TeamData.entity(), insertInto: context)
//                teamData.id = team.id
//                teamData.icon = team.icon
//                teamData.photo = team.photo
//                teamData.teamName = team.name
//                teamData.teamDescription = team.teamDescription
//                do {
//                   try context.save()
//                  } catch {
//                   print("Failed saving team.")
//                }
//            }
//        }
//    }
//
//    func retrieveTeams() -> [Team] {
//        //guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
//        let context = appDelegate.persistentContainer.viewContext
//        var request = NSFetchRequest<NSFetchRequestResult>()
//        request = TeamData.fetchRequest()
//        request.returnsObjectsAsFaults = false
//
//        var teams: [Team] = []
//        do {
//            if let result = try context.fetch(request) as? [TeamData] {
//                for team in result{
//                    teams.append(Team(id: team.id ?? "",
//                                      icon: team.icon ?? "",
//                                      photo: team.photo ?? "",
//                                      teamName: team.teamName ?? "",
//                                      description: team.teamDescription ?? ""))
//                }
//            }
//        } catch {
//            print("Failed")
//        }
//        return teams
//    }
//
//    func deleteAllData(entity: String) {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//
//        fetchAndDeleteObjects(forContext: context, withRequest: fetchRequest)
//    }
//}
//
//    // MARK: Events
//
//extension CoreDataService: EventsPersistable {
//    func createEvents(events: [Event]?) {
//        let context = appDelegate.persistentContainer.viewContext
//
//        guard let events = events else { return }
//        for event in events {
//            if !isEntityWithKeyExists(entity: "EventData", format: "eventID", key: event.eventID) {
//                let eventData = EventData(entity: EventData.entity(), insertInto: context)
//                eventData.eventID = event.eventID
//                eventData.date = event.date
//                eventData.firstTeam = event.firstTeamName
//                eventData.secondTeam = event.secondTeamName
//                eventData.homeTeamID = event.homeTeamID
//                eventData.awayTeamID = event.awayTeamID
//                do {
//                   try context.save()
//                  } catch {
//                    context.undo()
//                    print("Failed saving event. \(event.eventID)")
//                }
//            }
//        }
//    }
//
//    func retrieveEvents(team: Team) -> [Event] {
//        let context = appDelegate.persistentContainer.viewContext
//        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EventData")
//        let chekingHomeTeamPredicate = NSPredicate(format: "homeTeamID = %@", team.id)
//        let checkingAwayTeamPredicate = NSPredicate(format: "awayTeamID = %@", team.id)
//        let orPredicate = NSCompoundPredicate(type: .or, subpredicates: [chekingHomeTeamPredicate, checkingAwayTeamPredicate])
//
//        request.predicate = orPredicate
//        request.returnsObjectsAsFaults = false
//
//        var events: [Event] = []
//        do {
//            if let result = try context.fetch(request) as? [EventData] {
//                for event in result {
//                    events.append(Event(eventID: event.eventID ?? "",
//                                        homeTeamID: event.homeTeamID ?? "",
//                                        awayTeamID: event.awayTeamID ?? "",
//                                        date: event.date ?? "",
//                                        firstTeam: event.firstTeam ?? "",
//                                        secondTeam: event.secondTeam ?? ""))
//                }
//            }
//        } catch {
//            print("Failed")
//        }
//        return events
//    }
//
//    func deleteAllEventDataWithTeamId(team: Team) {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventData")
//        let chekingHomeTeamPredicate = NSPredicate(format: "homeTeamID = %@", team.id)
//        let checkingAwayTeamPredicate = NSPredicate(format: "awayTeamID = %@", team.id)
//        let orPredicate = NSCompoundPredicate(type: .or, subpredicates: [chekingHomeTeamPredicate, checkingAwayTeamPredicate])
//        fetchRequest.predicate = orPredicate
//        fetchRequest.returnsObjectsAsFaults = false
//
//        fetchAndDeleteObjects(forContext: context, withRequest: fetchRequest)
//    }
//}
//
//    //MARK: Players
//
//extension CoreDataService: PlayersPersistable {
//    func createPlayers(players: [Player]?) {
//        let context = appDelegate.persistentContainer.viewContext
//
//        guard let players = players else { return }
//        for player in players {
//            if !isEntityWithKeyExists(entity: "PlayerData", format: "name", key: player.name) {
//                let playerData = PlayerData(entity: PlayerData.entity(), insertInto: context)
//                playerData.teamID = player.teamID
//                playerData.icon = player.icon
//                playerData.name = player.name
//                playerData.age = player.age
//                playerData.height = player.height
//                playerData.weight = player.weight
//                playerData.playerDescription = player.playerDescription
//                do {
//                    try context.save()
//                } catch {
//                    print("Failed saving player.")
//                }
//            }
//        }
//    }
//
//    func retrievePlayers(team: Team) -> [Player] {
//        let context = appDelegate.persistentContainer.viewContext
//        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "PlayerData")
//        request.predicate = NSPredicate(format: "teamID = %@", team.id)
//        request.returnsObjectsAsFaults = false
//
//        var players: [Player] = []
//        do {
//            if let result = try context.fetch(request) as? [PlayerData] {
//                for player in result {
//                    players.append(Player(teamID: player.teamID ?? "",
//                                          icon: player.icon ?? "https://sweettutos.com/wp-content/uploads/2015/12/placeholder.png",
//                                          name: player.name ?? "",
//                                          age: player.age ?? "",
//                                          height: player.height ?? "",
//                                          weight: player.weight ?? "",
//                                          description: player.playerDescription ?? ""))
//                }
//            }
//        } catch {
//            print("Failed")
//        }
//        return players
//    }
//
//    func deleteAllPlayerDataWithTeamId(team: Team) {
//        let context = appDelegate.persistentContainer.viewContext
//        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "PlayerData")
//        request.predicate = NSPredicate(format: "teamID = %@", team.id)
//        request.returnsObjectsAsFaults = false
//
//        fetchAndDeleteObjects(forContext: context, withRequest: request)
//    }
//}
//
//extension CoreDataService {
//    private func isEntityWithKeyExists(entity: String, format: String, key: String) -> Bool {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
//        fetchRequest.predicate = NSPredicate(format: "\(format) = %@", key)
//        let res = try! context.fetch(fetchRequest)
//        return res.count > 0 ? true : false
//    }
//}
