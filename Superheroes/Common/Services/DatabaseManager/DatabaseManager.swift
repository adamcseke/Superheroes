//
//  DatabaseManager.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 16..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation
import SQLite

protocol SuperheroesDatabaseManager: AnyObject {
    func insert(entity: Heroes, completion: BoolCompletition?)
    func getHeroes() -> [Heroes]
    func delete(entity: Heroes, completion: BoolCompletition?)
    func insertComment(entity: Heroes, comment: String, date: Date, completion: BoolCompletition?)
    func getComments(entity: Heroes) -> [String]
    func deleteComment(entity: Heroes, completion: BoolCompletition?)
    func insertSearchedHeroes(entity: Heroes, completion: BoolCompletition?)
    func getSearchedHeroes(name: String) -> [Heroes]
}

class DatabaseManager: SuperheroesDatabaseManager {
    // MARK: Singleton
    static let main = DatabaseManager()
    init() {
        openIfNeeded()
    }
    
    internal var database: Connection?
    
    private let databaseName = "hero"
    
    fileprivate let hero = Table("heroes")
    fileprivate let heroID = Expression<String>("id")
    fileprivate let heroName = Expression<String?>("name")
    fileprivate let url = Expression<String?>("url")
    fileprivate let intelligence = Expression<String?>("intelligence")
    fileprivate let strength = Expression<String?>("strength")
    fileprivate let speed = Expression<String?>("speed")
    fileprivate let durability = Expression<String?>("durability")
    fileprivate let power = Expression<String?>("power")
    fileprivate let combat = Expression<String?>("combat")
    fileprivate let fullName = Expression<String?>("fullName")
    fileprivate let alterEgos = Expression<String?>("alterEgos")
    fileprivate let alias = Expression<String?>("alias")
    fileprivate let placeOfBirth = Expression<String?>("placeOfBirth")
    fileprivate let firstAppearance = Expression<String?>("firstAppearance")
    fileprivate let publisher = Expression<String?>("publisher")
    fileprivate let alignment = Expression<String?>("alignment")
    fileprivate let gender = Expression<String?>("gender")
    fileprivate let race = Expression<String?>("race")
    fileprivate let heightMetric = Expression<String?>("heightMetric")
    fileprivate let weightMetric = Expression<String?>("weightMetric")
    fileprivate let eyeColor = Expression<String?>("eyeColor")
    fileprivate let hairColor = Expression<String?>("hairColor")
    fileprivate let occupation = Expression<String?>("occupation")
    fileprivate let base = Expression<String?>("base")
    fileprivate let groupAffiliation = Expression<String?>("groupAffiliation")
    fileprivate let relatives = Expression<String?>("relatives")
    fileprivate let isFavorite = Expression<Bool?>("isFavorite")
    
    fileprivate let userComments = Table("comments")
    fileprivate let userComment = Expression<String?>("comment")
    fileprivate let dateOfComment = Expression<Date>("date")
    
    fileprivate let searched = Table("searched")
    
    
    internal func openIfNeeded() {
        if self.database != nil {
            return
        }
        self.copyDatabaseIfNeeded(self.databaseName)
        if let path = NSSearchPathForDirectoriesInDomains(
            .libraryDirectory, .userDomainMask, true
        ).first {
            print(path)
            do {
                let database = try Connection("\(path)/\(databaseName).sqlite")
                print("Database opened...")
                self.database = database
                
                try database.run(hero.create { tColoumn in
                    tColoumn.column(heroName)
                    tColoumn.column(url)
                    tColoumn.column(heroID, primaryKey: true)
                    tColoumn.column(intelligence)
                    tColoumn.column(strength)
                    tColoumn.column(speed)
                    tColoumn.column(durability)
                    tColoumn.column(power)
                    tColoumn.column(combat)
                    tColoumn.column(fullName)
                    tColoumn.column(alterEgos)
                    tColoumn.column(placeOfBirth)
                    tColoumn.column(firstAppearance)
                    tColoumn.column(publisher)
                    tColoumn.column(alignment)
                    tColoumn.column(gender)
                    tColoumn.column(race)
                    tColoumn.column(eyeColor)
                    tColoumn.column(hairColor)
                    tColoumn.column(occupation)
                    tColoumn.column(base)
                    tColoumn.column(groupAffiliation)
                    tColoumn.column(relatives)
                    tColoumn.column(isFavorite)
                    tColoumn.column(alias)
                    tColoumn.column(heightMetric)
                    tColoumn.column(weightMetric)
                })
                
                try database.run(userComments.create { tColoumn in
                    tColoumn.column(heroID)
                    tColoumn.column(dateOfComment)
                    tColoumn.column(userComment)
                    tColoumn.primaryKey(heroID, dateOfComment)
                })
                
                try database.run(searched.create { tColoumn in
                    tColoumn.column(heroName)
                    tColoumn.column(url)
                    tColoumn.column(heroID, primaryKey: true)
                    tColoumn.column(intelligence)
                    tColoumn.column(strength)
                    tColoumn.column(speed)
                    tColoumn.column(durability)
                    tColoumn.column(power)
                    tColoumn.column(combat)
                    tColoumn.column(fullName)
                    tColoumn.column(alterEgos)
                    tColoumn.column(placeOfBirth)
                    tColoumn.column(firstAppearance)
                    tColoumn.column(publisher)
                    tColoumn.column(alignment)
                    tColoumn.column(gender)
                    tColoumn.column(race)
                    tColoumn.column(eyeColor)
                    tColoumn.column(hairColor)
                    tColoumn.column(occupation)
                    tColoumn.column(base)
                    tColoumn.column(groupAffiliation)
                    tColoumn.column(relatives)
                    tColoumn.column(isFavorite)
                    tColoumn.column(alias)
                    tColoumn.column(heightMetric)
                    tColoumn.column(weightMetric)
                })
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func copyDatabaseIfNeeded(_ database: String) {
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)
        if documentsUrl.isEmpty { return }
        
        guard let finalDatabaseURL = documentsUrl.first?.appendingPathComponent("\(database).sqlite") else {
            print("finalDatabaseURL is nil")
            return
        }
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(database).sqlite")
            
            do {
                guard let fromPath = databaseInMainBundleURL?.path else {
                    print("fromPath is nil")
                    return
                }
                try fileManager.copyItem(atPath: fromPath, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }
    
    func insert(entity: Heroes, completion: BoolCompletition?) {
        self.openIfNeeded()
        let insert = hero.insert(
            heroName <- entity.name,
            url <- entity.image.url,
            heroID <- entity.id,
            intelligence <- entity.powerstats.intelligence,
            strength <- entity.powerstats.strength,
            speed <- entity.powerstats.speed,
            durability <- entity.powerstats.durability,
            power <- entity.powerstats.power,
            combat <- entity.powerstats.combat,
            fullName <- entity.biography.fullName,
            alterEgos <- entity.biography.alterEgos,
            placeOfBirth <- entity.biography.placeOfBirth,
            firstAppearance <- entity.biography.firstAppearance,
            publisher <- entity.biography.publisher,
            alignment <- entity.biography.alignment,
            gender <- entity.appearance.gender,
            race <- entity.appearance.race,
            eyeColor  <- entity.appearance.eyeColor,
            hairColor <- entity.appearance.hairColor,
            occupation <- entity.work.occupation,
            base <- entity.work.base,
            groupAffiliation <- entity.connections.groupAffiliation,
            relatives <- entity.connections.relatives,
            isFavorite <- entity.isFavorite,
            alias <- entity.biography.alias,
            heightMetric <- entity.appearance.heightMetric,
            weightMetric <- entity.appearance.weighttMetric
        )
        
        do {
            _ = try database?.run(insert)
            print("Hero inserted to database... \(entity.name)")
            completion?(true)
        } catch let error {
            print(error.localizedDescription)
            completion?(false)
        }
    }
    
    func getHeroes() -> [Heroes] {
        var heroes: [Heroes] = []
        if let db = database {
            
            do {
                for hero in try db.prepare(hero) {
                    
                    let powerstats = Powerstats(intelligence: hero[intelligence], strength: hero[strength], speed: hero[speed], durability: hero[durability], power: hero[power], combat: hero[combat])
                    
                    let biography = Biography(fullName: hero[fullName], alterEgos: hero[alterEgos], placeOfBirth: hero[placeOfBirth], firstAppearance: hero[firstAppearance], publisher: hero[publisher], alignment: hero[alignment])
                    
                    let appearance = Appearance(gender: hero[gender], race: hero[race], eyeColor: hero[eyeColor], hairColor: hero[hairColor])
                    
                    let work = Work(occupation: hero[occupation], base: hero[base])
                    
                    let connections = Connections(groupAffiliation: hero[groupAffiliation], relatives: hero[relatives])
                    
                    let image = Image(url: hero[url])
                    
                    let superhero = Heroes(id: hero[heroID] ?? "", name: hero[heroName] ?? "", powerstats: powerstats, biography: biography, appearance: appearance, work: work, connections: connections, image: image, isFavorite: hero[isFavorite] ?? false, alias: hero[alias] ?? "", height: hero[heightMetric] ?? "", weight: hero[weightMetric] ?? "")
                    
                    heroes.append(superhero)
                }
            } catch {
                print (error)
            }
        }
        
        return heroes
    }
    
    func delete(entity: Heroes, completion: BoolCompletition?) {
        self.openIfNeeded()
        let item = self.hero.filter(heroID == entity.id)
        do {
            try database?.run(item.delete())
            print("Hero deleted from database... \(entity.name)")
            completion?(true)
        } catch let error {
            print(error)
            completion?(false)
        }
    }
    
    func insertComment(entity: Heroes, comment: String, date: Date, completion: BoolCompletition?) {
        self.openIfNeeded()
        let insert = userComments.insert(
            heroID <- entity.id,
            userComment <- comment,
            dateOfComment <- date
        )
        
        do {
            _ = try database?.run(insert)
            print("Comment saved to database...\(comment)")
            completion?(true)
        } catch let error {
            print(error.localizedDescription)
            print(String(describing: error))
            completion?(false)
        }
    }
    
    func getComments(entity: Heroes) -> [String] {
        var uComments: [String] = []
        if let db = database {
            
            do {
                for comment in try db.prepare(userComments) {
                    
                    let allComments = comment[userComment] ?? ""
                    
                    if comment[heroID] == entity.id {
                        uComments.append(allComments)
                    }
                }
            } catch {
                print(error)
            }
        }
        
        return uComments
    }
    
    func deleteComment(entity: Heroes, completion: BoolCompletition?) {
        self.openIfNeeded()
        let item = self.userComments.filter(heroID == entity.id)
        do {
            try database?.run(item.delete())
            print("Hero's comment deleted from database... \(userComment)")
            completion?(true)
        } catch let error {
            print(error)
            completion?(false)
        }
    }
    
    func insertSearchedHeroes(entity: Heroes, completion: BoolCompletition?) {
        self.openIfNeeded()
        let insert = searched.insert(
            heroID <- entity.id,
            heroName <- entity.name,
            url <- entity.image.url
        )
        
        do {
            _ = try database?.run(insert)
            print("Comment saved to database...\(heroID)")
            completion?(true)
        } catch let error {
            print(error.localizedDescription)
            print(String(describing: error))
            completion?(false)
        }
    }
    
    func getSearchedHeroes(name: String) -> [Heroes] {
        var heroes: [Heroes] = []
        if let db = database {
            
            do {
                for hero in try db.prepare(searched) {
                 
                    let powerstats = Powerstats(intelligence: hero[intelligence], strength: hero[strength], speed: hero[speed], durability: hero[durability], power: hero[power], combat: hero[combat])
                    
                    let biography = Biography(fullName: hero[fullName], alterEgos: hero[alterEgos], placeOfBirth: hero[placeOfBirth], firstAppearance: hero[firstAppearance], publisher: hero[publisher], alignment: hero[alignment])
                    
                    let appearance = Appearance(gender: hero[gender], race: hero[race], eyeColor: hero[eyeColor], hairColor: hero[hairColor])
                    
                    let work = Work(occupation: hero[occupation], base: hero[base])
                    
                    let connections = Connections(groupAffiliation: hero[groupAffiliation], relatives: hero[relatives])
                    
                    let image = Image(url: hero[url])
                    
                    let superhero = Heroes(id: hero[heroID] ?? "", name: hero[heroName] ?? "", powerstats: powerstats, biography: biography, appearance: appearance, work: work, connections: connections, image: image, isFavorite: hero[isFavorite] ?? false, alias: hero[alias] ?? "", height: hero[heightMetric] ?? "", weight: hero[weightMetric] ?? "")
                    
                    heroes.append(superhero)
                }
            } catch {
                print(error)
            }
        }
        
        return heroes
    }
    
}
