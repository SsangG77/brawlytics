//
//  BrawlerTrophyModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import Foundation

struct BrawlerTrophyModel: Codable, Equatable {
    var id = UUID()
    var name: String
    var currentTrophy: Int
    var highestTrophy: Int
}
