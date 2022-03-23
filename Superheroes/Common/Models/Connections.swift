//
//  Connections.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation: String
    let relatives: String

    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "group-affiliation"
        case relatives
    }
    
    init(groupAffiliation: String?, relatives: String?) {
        self.groupAffiliation = groupAffiliation ?? ""
        self.relatives = relatives ?? ""
    }
}
