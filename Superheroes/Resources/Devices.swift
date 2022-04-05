//
//  Devices.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 07..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

extension UIDevice {
    
    enum Devices {
        static var iPhoneSE1stGen: Bool { UIScreen.main.nativeBounds.height == 1136 }
        static var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
        static var iPhone8: Bool { UIScreen.main.nativeBounds.height == 1334 }
    }
    
    enum ScreenType: String {
        case iPhonesSE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhonesSE
        case 1334: return .iPhones8
        default: return .unknown
        }
    }
}
