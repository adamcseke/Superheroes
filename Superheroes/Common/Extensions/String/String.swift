//
//  String.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

extension String {
    /// Localization: Returns a localized string
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
