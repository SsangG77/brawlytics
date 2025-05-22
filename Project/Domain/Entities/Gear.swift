//
//  Gear.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation

enum EpicGear: String {
    case reloadSpeed = "RELOAD SPEED"
    case superCharge = "SUPER CHARGE"
    case petPower = "PET POWER"
    case none
}

enum MythicGear: String {
    case thiccHead = "THICC HEAD"
    case talkToTheHand = "TALK TO THE HAND"
    case enduringToxin = "ENDURING TOXIN"
    case exhaustingStorm = "EXHAUSTING STORM"
    case stickySpikes = "STICKY SPIKES"
    case lingeringSmoke = "LINGERING SMOKE"
    case stickyOil = "STICKY OIL"
    case quadruplets = "QUADRUPLETS"
    case superTurret = "SUPER TURRET"
    case batStorm = "BAT STORM"
    case none = ""
}

enum RareGear: String, CaseIterable {
    case speed = "SPEED"
    case health = "HEALTH"
    case damage = "DAMAGE"
    case vision = "VISION"
    case shield = "SHIELD"
    case gadgetCooldown = "GADGET COOLDOWN"
}
