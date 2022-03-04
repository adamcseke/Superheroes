//
//  Superheroes.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

// MARK: - Superheroes
struct Superheroes: Codable {
    let response: String
    let resultsFor: String
    let results: [Heroes]

    enum CodingKeys: String, CodingKey {
        case response
        case resultsFor = "results-for"
        case results
    }
}
