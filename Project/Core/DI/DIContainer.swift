//
//  DIContainer.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import Foundation


class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Services
    private lazy var brawlersDataSource: BrawlersDataSource = {
        return BrawlersDataSource()
    }()
    
    private lazy var hyperchargeDataSource: HyperchargeDataSource = {
        return HyperchargeDataSourceImpl()
    }()
    
    // MARK: - Repositories
    private lazy var brawlersRepository: BrawlersRepository = {
        return BrawlersRepositoryImpl(
            brawlersDataSource: brawlersDataSource,
            dataSource: hyperchargeDataSource
        )
    }()
    
    private lazy var searchHistoryRepository: SearchHistoryRepository = {
        return SearchHistoryRepositoryImpl()
    }()
    
    private lazy var remoteDataSource: BrawlerRemoteDataSource = {
        return BrawlerRemoteDataSourceImpl()
    }()
    
    private lazy var remoteRepository: RemoteRepository = {
        return RemoteRepositoryImpl(remoteDataSource: remoteDataSource)
    }()
    
    // MARK: - UseCases
    private lazy var calculateUseCase: CalculateUseCase = {
        return CalculateUseCaseImpl(repository: remoteRepository)
    }()
    
    private lazy var brawlersUseCase: BrawlersUseCase = {
        return BrawlersUseCaseImpl(repository: brawlersRepository)
    }()
    
    // MARK: - ViewModels
    func makeBrawlersViewModel() -> BrawlersViewModel {
        return BrawlersViewModel(
            repository: brawlersRepository,
            useCase: brawlersUseCase,
            judge: BrawlerJudgeImpl()
        )
    }
    
    func makeCalculateViewModel() -> CalculateViewModel {
        return CalculateViewModel(calculateUseCase: calculateUseCase)
    }
    
    func makeSearchBarViewModel() -> SearchBarViewModel {
        return SearchBarViewModel(repository: searchHistoryRepository)
    }
}
