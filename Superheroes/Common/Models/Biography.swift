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
    
    init(fullName: String?, alterEgos: String?, placeOfBirth: String?, firstAppearance: String?, publisher: String?, alignment: String?, aliases: [String]? = nil) {
        self.fullName = fullName ?? ""
        self.alterEgos = alterEgos ?? ""
        self.placeOfBirth = placeOfBirth ?? ""
        self.firstAppearance = firstAppearance ?? ""
        self.publisher = publisher ?? ""
        self.alignment = alignment ?? ""
        self.aliases = aliases ?? [""]
    }
}

extension Biography {
    
    var alias: String {
        get { return aliases.joined(separator: ", ") }
        set { aliases = newValue.components(separatedBy: ", ") }
    }
}
