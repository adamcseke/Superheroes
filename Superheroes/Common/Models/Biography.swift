//
//  Biography.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

// MARK: - Biography
struct Biography: Codable {
    let fullName: String
    let alterEgos: String
    var aliases: [String]
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String
    let alignment: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case aliases
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher
        case alignment
    }
}

extension Biography {
    
    var alias: String {
        get { return aliases.joined(separator: ", ") }
        set { aliases = newValue.components(separatedBy: ", ") }
    }
}
