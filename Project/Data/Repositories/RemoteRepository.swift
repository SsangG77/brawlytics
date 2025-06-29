//
//  RemoteRepository.swift
//  Brawlytics
//
//  Created by 차상진 on 5/24/25.
//

import Foundation
import RxSwift


protocol RemoteRepository {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
}

class RemoteRepositoryImpl: RemoteRepository {
    private let remoteDataSource: BrawlerRemoteDataSource
    
    init(remoteDataSource: BrawlerRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
        remoteDataSource.getUserBrawlers(searchText: searchText, completion: completion)
    }
    
}

//MARK: - Rx
protocol RxRemoteRepository {
    func getUserBrawlers(searchText: String) -> Observable<[Brawler]>
    func getBrawlerStandard() -> [BrawlerStandard]
}

class RxRemoteRepositoryImpl: RxRemoteRepository {
    private let rxRemoteDataSource: RxRemoteDataSource
    private let brawlersDataSource: BrawlersDataSource
    
    init(
        rxRemoteDataSource: RxRemoteDataSource,
        brawlersDataSource: BrawlersDataSource
    ) {
        self.rxRemoteDataSource = rxRemoteDataSource
        self.brawlersDataSource = brawlersDataSource
    }
    
    func getUserBrawlers(searchText: String) -> Observable<[Brawler]> {
        return rxRemoteDataSource.getUserBrawlers(searchText: searchText)
    }
    
    func getBrawlerStandard() -> [BrawlerStandard] {
        return brawlersDataSource.allBrawlers
    }
}
