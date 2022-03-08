//
//  Devices.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 07..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

extension UIDevice {
    
    enum Devices{
        static var iPhoneSE1stGen: Bool { UIScreen.main.nativeBounds.height == 1136 }
        static var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    }
    
    enum ScreenType: String {
        case iPhonesSE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhonesSE
        default: return .unknown
        }
    }
}
