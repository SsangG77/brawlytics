//
//  PlayerProfileRepository.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift

protocol PlayerProfileRepository {
    func fetchUserProfile() -> Observable<UserTrophyModel>
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]>
}

class PlayerProfileRepositoryImpl: PlayerProfileRepository {
    let dataSource: PlayerProfileDataSource
    
    init(dataSource: PlayerProfileDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return dataSource.fetchUserProfile()
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return dataSource.fetchBrawlersTrophy()
    }
}
