//
//  Heroes.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

protocol SearchedCollectionViewCellBindable {
    var name: String { get }
    var image: Image { get }
}

// MARK: - Result
struct Heroes: Codable, Hashable {
    let id: String
    let name: String
    let powerstats: Powerstats
    var biography: Biography
    var appearance: Appearance
    let work: Work
    let connections: Connections
    let image: Image
    var isFavorite: Bool {
        get { _isFavorite ?? false }
        set { _isFavorite = newValue }
    }

    private var _isFavorite: Bool?

    static func == (lhs: Heroes, rhs: Heroes) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: String, name: String, powerstats: Powerstats, biography: Biography, appearance: Appearance, work: Work, connections: Connections, image: Image, isFavorite: Bool, alias: String, height: String, weight: String) {
        self.id = id
        self.name = name
        self.powerstats = powerstats
        self.biography = biography
        self.appearance = appearance
        self.work = work
        self.connections = connections
        self.image = image
        self.isFavorite = isFavorite
        self.biography.alias = alias
        self.appearance.heightMetric = height
        self.appearance.weighttMetric = weight
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
}

struct HeroViewModel {
    let name: String
    let image: Image
    
    init(hero: Heroes) {
        self.name = hero.name
        self.image = hero.image
    }
}

extension HeroViewModel: SearchedCollectionViewCellBindable {
    
}
