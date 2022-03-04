//
//  RestClient+Superheroes.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

protocol SuperheroesService: AnyObject {
    func getSuperheroes(name: String, completion: @escaping SuperheroesLoaded )
}

extension RestClient: SuperheroesService {
    func getSuperheroes(name: String, completion: @escaping SuperheroesLoaded) {
        let escapedName = name.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? ""
        let url = Constants.baseUrl + "/search/\(escapedName)"
        request(urlString: url, completion: completion)
    }
}
