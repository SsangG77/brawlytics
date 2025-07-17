//
//  BattleLogRepository.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift

protocol BattleLogRepository {
    func fetchBattleLog() -> Observable<[BattleLogModel]>
}

class BattleLogRepositoryImpl: BattleLogRepository {
    let dataSource: BattleLogDataSource
    
    init(dataSource: BattleLogDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return dataSource.fetchBattleLog()
    }
}
