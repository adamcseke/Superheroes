//
//  Work.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

// MARK: - Work
struct Work: Codable {
    let occupation: String
    let base: String
    
    init(occupation: String?, base: String?) {
        self.occupation = occupation ?? ""
        self.base = base ?? ""
    }
}
