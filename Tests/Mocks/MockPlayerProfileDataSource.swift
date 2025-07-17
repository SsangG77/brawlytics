//
//  MockPlayerProfileDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift



class MockPlayerProfileDataSourceImpl: PlayerProfileDataSource {
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return Observable.just(
            UserTrophyModel(
               nickName: "상진",
               club: "팀",
//               rank: "diamond",
               total: 9200,
               max: 10000
            )
        )
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return Observable.just([
            BrawlerTrophyModel(id: UUID().uuidString, name: "Shelly", rank: 51, currentTrophy: 540, highestTrophy: 900),
            BrawlerTrophyModel(id: UUID().uuidString, name: "Bull", rank: 50, currentTrophy: 140, highestTrophy: 500),
            BrawlerTrophyModel(id: UUID().uuidString, name: "Kaze", rank: 21, currentTrophy: 220, highestTrophy: 590),
            BrawlerTrophyModel(id: UUID().uuidString, name: "Penny", rank: 11, currentTrophy: 190, highestTrophy: 503),
            
        ])
    }
}


