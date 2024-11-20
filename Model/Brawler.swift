//
//  Brawler.swift
//  Brawlytics
//
//  Created by 차상진 on 11/6/24.
//

import Foundation

struct Brawler: Codable {
    let id: Int
    let name: String
    let power: Int
    let rank: Int
    let trophies: Int
    let highestTrophies: Int
    let gears: [Gear]
    let starPowers: [StarPower]
    let gadgets: [Gadget]
    
    init() {
        id = 0
        name = ""
        power = 0
        rank = 0
        trophies = 0
        highestTrophies = 0
        gears = []
        starPowers = []
        gadgets = []
    }
    
    
}

struct Gear: Codable {
    let id: Int
    let name: String
    let level: Int
}

struct StarPower: Codable {
    let id: Int
    let name: String
}

struct Gadget: Codable {
    let id: Int
    let name: String
}
