////
////  DatabaseManager.swift
////  Superheroes
////
////  Created by Adam Cseke on 2022. 03. 16..
////  Copyright © 2022. levivig. All rights reserved.
////
//
//import Foundation
//import SQLite
//
//protocol SuperheroesDatabaseManager: AnyObject {
//    func insert(entity: Heroes, completion: BoolCompletition?)
//    func getHeroes() -> Heroes
//    func delete(entity: Heroes, completion: BoolCompletition?)
//}
//
//class DatabaseManager: SuperheroesDatabaseManager {
//    // MARK: Singleton
//    static let main = DatabaseManager()
//    init() {
//        openIfNeeded()
//    }
//
//    internal var database: Connection?
//
//    private let databaseName = "hero"
//
//    fileprivate let hero = Table("heroes")
//    fileprivate let heroID = Expression<String?>("id")
//    fileprivate let heroName = Expression<String>("name")
//    fileprivate let heroImageUrl = Expression<String?>("image")
//    fileprivate let intelligence = Expression<String?>("intelligence")
//    fileprivate let strength = Expression<String?>("strength")
//    fileprivate let speed = Expression<String?>("speed")
//    fileprivate let durability = Expression<String?>("durability")
//    fileprivate let power = Expression<String?>("power")
//    fileprivate let combat = Expression<String?>("combat")
//    fileprivate let fullName = Expression<String?>("fullName")
//    fileprivate let alterEgos = Expression<String?>("alterEgos")
//    fileprivate let aliases = Expression<String?>("aliases")
//    fileprivate let placeOfBirth = Expression<String?>("placeOfBirth")
//    fileprivate let firstAppearance = Expression<String?>("firstAppearance")
//    fileprivate let publisher = Expression<String?>("publisher")
//    fileprivate let alignment = Expression<String?>("alignment")
//    fileprivate let gender = Expression<String?>("gender")
//    fileprivate let race = Expression<String?>("race")
//    fileprivate let height = Expression<String?>("height")
//    fileprivate let weight = Expression<String?>("weight")
//    fileprivate let eyeColor = Expression<String?>("eyeColor")
//    fileprivate let hairColor = Expression<String?>("hairColor")
//    fileprivate let occupation = Expression<String?>("occupation")
//    fileprivate let base = Expression<String?>("base")
//    fileprivate let groupAffiliation = Expression<String?>("groupAffiliation")
//    fileprivate let relatives = Expression<String?>("relatives")
//
//
//    internal func openIfNeeded() {
//        if self.database != nil {
//            return
//        }
//        self.copyDatabaseIfNeeded(self.databaseName)
//        if let path = NSSearchPathForDirectoriesInDomains(
//            .libraryDirectory, .userDomainMask, true
//        ).first {
//            print(path)
//            do {
//                let database = try Connection("\(path)/\(databaseName).sqlite")
//                print("Database opened...")
//                self.database = database
//
//                try database.run(hero.create { tColoumn in
//                    tColoumn.column(heroName, primaryKey: true)
//                    tColoumn.column(heroImageUrl)
//                    tColoumn.column(heroID)
//                    tColoumn.column(intelligence)
//                    tColoumn.column(strength)
//                    tColoumn.column(speed)
//                    tColoumn.column(durability)
//                    tColoumn.column(power)
//                    tColoumn.column(combat)
//                    tColoumn.column(fullName)
//                    tColoumn.column(alterEgos)
//                    tColoumn.column(placeOfBirth)
//                    tColoumn.column(firstAppearance)
//                    tColoumn.column(publisher)
//                    tColoumn.column(alignment)
//                    tColoumn.column(gender)
//                    tColoumn.column(race)
//                    tColoumn.column(eyeColor)
//                    tColoumn.column(hairColor)
//                    tColoumn.column(occupation)
//                    tColoumn.column(base)
//                    tColoumn.column(groupAffiliation)
//                    tColoumn.column(relatives)
//                })
//
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    private func copyDatabaseIfNeeded(_ database: String) {
//        let fileManager = FileManager.default
//        let documentsUrl = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)
//        if documentsUrl.isEmpty { return }
//
//        guard let finalDatabaseURL = documentsUrl.first?.appendingPathComponent("\(database).sqlite") else {
//            print("finalDatabaseURL is nil")
//            return
//        }
//
//        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
//            print("DB does not exist in documents folder")
//            let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(database).sqlite")
//
//            do {
//                guard let fromPath = databaseInMainBundleURL?.path else {
//                    print("fromPath is nil")
//                    return
//                }
//                try fileManager.copyItem(atPath: fromPath, toPath: finalDatabaseURL.path)
//            } catch let error as NSError {
//                print("Couldn't copy file to final location! Error:\(error.description)")
//            }
//        } else {
//            print("Database file found at path: \(finalDatabaseURL.path)")
//        }
//    }
//
//    func insert(entity: Heroes, completion: BoolCompletition?) {
//        self.openIfNeeded()
//        let insert = hero.insert(
//            heroName <- entity.name.lowercased(),
//            heroImageUrl <- entity.image.url,
//            heroID <- entity.id,
//            intelligence <- entity.powerstats.intelligence,
//            strength <- entity.powerstats.strength,
//            speed <- entity.powerstats.speed,
//            durability <- entity.powerstats.durability,
//            power <- entity.powerstats.power,
//            combat <- entity.powerstats.combat,
//            fullName <- entity.biography.fullName,
//            alterEgos <- entity.biography.alterEgos,
//            placeOfBirth <- entity.biography.placeOfBirth,
//            firstAppearance <- entity.biography.firstAppearance,
//            publisher <- entity.biography.publisher,
//            alignment <- entity.biography.alignment,
//            gender <- entity.appearance.gender,
//            race <- entity.appearance.race,
//            eyeColor  <- entity.appearance.eyeColor,
//            hairColor <- entity.appearance.hairColor,
//            occupation <- entity.work.occupation,
//            base <- entity.work.base,
//            groupAffiliation <- entity.connections.groupAffiliation,
//            relatives <- entity.connections.relatives
//        )
//
//        do {
//            _ = try database?.run(insert)
//            print("Hero inserted to database... \(entity.name)")
//            completion?(true)
//        } catch let error {
//            print(error.localizedDescription)
//            completion?(false)
//        }
//    }
//
//    func getHeroes() -> Heroes {
//        var heroes: Heroes
//        print(heroes)
//        if let db = database {
//
//            do {
//                for hero in try db.prepare(hero) {
//                    let superhero = Heroes(id: hero[heroID] ?? "", name: hero[heroName], powerstats: hero[intelligence], biography: <#T##Biography#>, appearance: <#T##Appearance#>, work: <#T##Work#>, connections: <#T##Connections#>, image: <#T##Image#>)
//                    heroes.append(superhero)
//                    print("login: \(hero[heroName]), avatarURL: \(hero[heroImageUrl] ?? "")")
//                }
//            } catch {
//                print (error)
//            }
//        }
//
//        return heroes
//    }
//
//    func delete(entity: Heroes, completion: BoolCompletition?) {
//        self.openIfNeeded()
//        let item = self.hero.filter(heroName == entity.name)
//        do {
//            try database?.run(item.delete())
//            print("Hero deleted from database...")
//            completion?(true)
//        } catch let error {
//            print(error)
//            completion?(false)
//        }
//    }
//
//}
