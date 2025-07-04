//
//  BrawlerTrophyModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import Foundation

struct BrawlerTrophyModel: Codable, Equatable, Identifiable {
    var id: String
    var name: String
    var rank: Int
    var currentTrophy: Int
    var highestTrophy: Int
}
