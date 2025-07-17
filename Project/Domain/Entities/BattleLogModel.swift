//
//  BattleLogModel.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation


struct BattleLogModel: Identifiable, Codable {
    var id = UUID()
    let result: String
    let mode: String
    let mapName: String
    let date: String
    let teams: [Team]
}

struct Team: Identifiable, Codable {
    var id = UUID()
    let member: [Member]
}

struct Member: Identifiable, Codable {
    var id = UUID()
    var name: String
    var brawler: String
    var power: Int
    var starPlayer: Bool
}
