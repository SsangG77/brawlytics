//
//  CalculateUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation
import RxSwift

protocol CalculateUseCase {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
    func findMyBrawler(brawlerName: String) -> Brawler
}

class CalculateUseCaseImpl: CalculateUseCase {
    
    var brawlers: [Brawler] = []
    let repository: RemoteRepository
    
    init (repository: RemoteRepository) {
        self.repository = repository
    }
    
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
           repository.getUserBrawlers(searchText: searchText) { [weak self] brawlers in
               self?.brawlers = brawlers
               completion(brawlers)
           }
       }

    func findMyBrawler(brawlerName: String) -> Brawler {
        return brawlers.first(where: { $0.name == brawlerName }) ?? Brawler()
    }
}

//MARK: - Rx
protocol RxCalculateUseCase {
    func getUserBrawlers(searchText: String) -> Observable<[Brawler]>
    func findMyBrawler(brawlerName: String) -> Brawler
}

class RxCalculateUseCaseImpl: RxCalculateUseCase {
    
    var brawlers: [Brawler] = []
    let repository: RxRemoteRepository
    
    init (repository: RxRemoteRepository) {
        self.repository = repository
    }
    
    func getUserBrawlers(searchText: String) -> Observable<[Brawler]> {
        return repository.getUserBrawlers(searchText: searchText)
            .do(onNext: { [weak self] brawlers in
                self?.brawlers = brawlers
            })
    }
    
    func findMyBrawler(brawlerName: String) -> Brawler {
        return brawlers.first(where: { $0.name == brawlerName }) ?? Brawler()
    }
}
