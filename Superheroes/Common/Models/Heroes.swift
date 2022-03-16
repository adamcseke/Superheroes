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
struct Heroes: Codable {
    let id: String
    let name: String
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let image: Image
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
