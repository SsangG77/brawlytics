//
//  UserTrophyModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/25/25.
//

import Foundation


struct UserTrophyModel: Codable {
    let id = UUID()
    let nickName: String
    let club: String
//    let rank: String
    let total: Int
    let max: Int
}



