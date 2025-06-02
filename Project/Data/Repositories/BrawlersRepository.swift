//
//  BrawlersRepository.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation

//MARK: - Repository
protocol BrawlersRepository {
    func getBrawlers() -> [BrawlerStandard]
    func judgeHypercharge(_ hypercharge: String) -> Bool
    func addHyperchargeArray(_ hypercharge: String)
    func removeHyperchargeArray(_ hypercharge: String)
}

class BrawlersRepositoryImpl: BrawlersRepository {
    private let brawlersDataSource: BrawlersDataSource
    private let dataSource: HyperchargeDataSource
    
    init(
        brawlersDataSource: BrawlersDataSource,
        dataSource: HyperchargeDataSource
    ) {
        self.brawlersDataSource = brawlersDataSource
        self.dataSource = dataSource
        
    }
   
    func getBrawlers() -> [BrawlerStandard] {
       return brawlersDataSource.allBrawlers
    }
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        return dataSource.judgeHypercharge(hypercharge)
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        dataSource.addHyperchargeArray(hypercharge)
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        dataSource.removeHyperchargeArray(hypercharge)
    }
}


