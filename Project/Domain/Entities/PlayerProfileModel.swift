//
//  PlayerProfileViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation


struct BrawlerTrophyModel: Codable, Equatable, Identifiable {
    var id: String
    var name: String
    var rank: Int
    var currentTrophy: Int
    var highestTrophy: Int
}


struct UserTrophyModel: Codable {
    let id = UUID()
    let nickName: String
    let club: String
    let total: Int
    let max: Int
}

