//
//  BrawlerStandard.swift
//  Brawlytics
//
//  Created by 차상진 on 5/19/25.
//

import Foundation

struct BrawlerStandard: Equatable {
    let id: UUID = UUID() // UUID를 자동 생성
    var name:String
    var first_gadget:String
    var second_gadget:String
    var first_starPower:String
    var second_starPower:String
    var hypercharge:String
    var rarity: Rarity // 희귀도
    var role: Role // 역할군
    var epicGear: EpicGear
    var mythicGear: MythicGear
}
