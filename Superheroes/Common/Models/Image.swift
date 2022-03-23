//
//  Image.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let url: String
    
    init(url: String?) {
        self.url = url ?? ""
    }
}
