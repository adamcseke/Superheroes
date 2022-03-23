//
//  Powerstat.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright © 2022. levivig. All rights reserved.
//

import Foundation

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence: String
    let strength: String
    let speed: String
    let durability: String
    let power: String
    let combat: String
    
    init(intelligence: String?, strength: String?, speed: String?, durability: String?, power: String?, combat: String?) {
        self.intelligence = intelligence ?? ""
        self.strength = strength ?? ""
        self.speed = speed ?? ""
        self.durability = durability ?? ""
        self.power = power ?? ""
        self.combat = combat ?? ""
    }
}

extension Powerstats {
    
    var totalStat: Double {
        let numIntelligence = Double(intelligence) ?? 0.0
        let numStrength = Double(strength) ?? 0.0
        let numSpeed = Double(speed) ?? 0.0
        let numDurability = Double(durability) ?? 0.0
        let numPower = Double(power) ?? 0.0
        let numCombat = Double(combat) ?? 0.0
        let stat = ((numIntelligence + numStrength + numSpeed + numDurability + numPower + numCombat) / 6) / 100
        return stat
    }
    
    var healthPoint: Double {
        let numIntelligence = Double(intelligence) ?? 0.0
        let numDurability = Double(durability) ?? 0.0
        let hp = (numIntelligence * 0.3) + (numDurability * 0.4) + 100
        return hp
    }
    
    var damage: Double {
        let numStrength = Double(strength) ?? 0.0
        let numPower = Double(power) ?? 0.0
        let numCombat = Double(combat) ?? 0.0
        let dam = ((numStrength / 10) + ((numPower + numCombat) / 2)) / 10
        return dam
    }
    
    var hitSpeed: Double {
        let numSpeed = Double(speed) ?? 0.0
        let spd = 1 - (numSpeed / 100)
        return spd
    }
}
