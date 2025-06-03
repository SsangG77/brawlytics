//
//  MockBrawlersRepository.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 5/28/25.
//

import Foundation
@testable import Brawlytics

class MockBrawlersRepository: BrawlersRepository {
    var brawlers: [BrawlerStandard] = []
    var hyperchargeArray: [String] = []
    
    func getBrawlers() -> [BrawlerStandard] {
        return brawlers
    }
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        return hyperchargeArray.contains(hypercharge)
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        if !hyperchargeArray.contains(hypercharge) {
            hyperchargeArray.append(hypercharge)
        }
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        if let index = hyperchargeArray.firstIndex(of: hypercharge) {
            hyperchargeArray.remove(at: index)
        }
    }
} 