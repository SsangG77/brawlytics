//
//  CalculateUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation
import RxSwift

protocol CalculateUseCase {
    func getUserBrawlers(searchText: String, completion: @escaping ([BrawlerDetail]) -> Void)
    func findMyBrawler(brawlerName: String) -> BrawlerDetail
}

class CalculateUseCaseImpl: CalculateUseCase {

    var brawlers: [BrawlerDetail] = []
    let repository: RemoteRepository

    init (repository: RemoteRepository) {
        self.repository = repository
    }

    func getUserBrawlers(searchText: String, completion: @escaping ([BrawlerDetail]) -> Void) {
           repository.getUserBrawlers(searchText: searchText) { [weak self] brawlers in
               self?.brawlers = brawlers
               completion(brawlers)
           }
       }

    func findMyBrawler(brawlerName: String) -> BrawlerDetail {
        return brawlers.first(where: { $0.name == brawlerName }) ?? BrawlerDetail()
    }
}

//MARK: - Rx
protocol RxCalculateUseCase {
    func getUserBrawlers(searchText: String) -> Observable<[BrawlerDetail]>
    func findMyBrawler(brawlerName: String) -> BrawlerDetail
    func getBrawlersStandard() -> [BrawlerStandard]
}

class RxCalculateUseCaseImpl: RxCalculateUseCase {

    var brawlers: [BrawlerDetail] = []
    let repository: RxRemoteRepository

    init (repository: RxRemoteRepository) {
        self.repository = repository
    }

    func getUserBrawlers(searchText: String) -> Observable<[BrawlerDetail]> {
        return repository.getUserBrawlers(searchText: searchText)
            .do(onNext: { [weak self] brawlers in
                self?.brawlers = brawlers
            })
    }

    func findMyBrawler(brawlerName: String) -> BrawlerDetail {
        return brawlers.first(where: { $0.name == brawlerName }) ?? BrawlerDetail()
    }

    func getBrawlersStandard() -> [BrawlerStandard] {
        return repository.getBrawlerStandard()
    }
}
