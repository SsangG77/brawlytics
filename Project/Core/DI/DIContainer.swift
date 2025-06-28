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
    
    private lazy var brawlersUseCase: BrawlersUseCase = {
        return BrawlersUseCaseImpl(repository: brawlersRepository)
    }()
    
    private lazy var searchBarUseCase: SearchBarUseCase = {
        return SearchBarUseCaseImpl(historyRepository: searchHistoryRepository)
    }()
    
    // MARK: - ViewModels
    func makeBrawlersViewModel() -> BrawlersViewModel {
        return BrawlersViewModel(
            repository: brawlersRepository,
            useCase: brawlersUseCase,
            judge: BrawlerJudgeImpl()
        )
    }
    
    func makeSearchBarViewModel() -> SearchBarViewModel {
        return SearchBarViewModel(useCase: searchBarUseCase)
    }
}





//MARK: - rx
class RxDIContainer {
    static let shared = RxDIContainer()
    
    private init() {}
    
    private lazy var dataSource: RxRemoteDataSource = {
        return RxRemoteDataSourceImpl()
    }()
    
    private lazy var brawlersDataSource: BrawlersDataSource = {
        return BrawlersDataSource()
    }()
    
    private lazy var remoteRepository: RxRemoteRepository = {
        return RxRemoteRepositoryImpl(
            rxRemoteDataSource: dataSource,
            brawlersDataSource: brawlersDataSource
        )
    }()
    
    private lazy var calculateUseCase: RxCalculateUseCase = {
        return RxCalculateUseCaseImpl(repository: remoteRepository)
    }()
    
    func makeCalculateViewModel() -> RxCalculateViewModel {
        return RxCalculateViewModel(useCase: calculateUseCase)
    }
    
    
    
    //MARK: - PlayerprofileView
    private lazy var playerProfileDataSource: PlayerProfileDataSource = {
        return MockPlayerProfileDataSourceImpl()
    }()
    
    private lazy var playerProfileRepository: PlayerProfileRepository = {
        return PlayerProfileRepositoryImpl(dataSource: playerProfileDataSource)
    }()
    
    private lazy var playerProfileUseCase: PlayerProfileUseCase = {
        return PlayerProfileUseCaseImpl(repository: playerProfileRepository)
    }()
    
    func makePlayerProfileViewModel() -> PlayerProfileViewModel {
        return PlayerProfileViewModel(useCase: playerProfileUseCase)
    }
    
    //MARK: - BattleLogView
    private lazy var battleLogDataSource: BattleLogDataSource = {
        return MockBattleLogDataSourceImpl()
    }()
    
    private lazy var battleLogRepository: BattleLogRepository = {
        return BattleLogRepositoryImpl(dataSource: battleLogDataSource)
    }()
    
    private lazy var battleLogUseCase: BattleLogUseCase = {
        return BattleLogUseCaseImpl(repository: battleLogRepository)
    }()
    
    func makeBattleLogViewModel() -> BattleLogViewModel {
        return BattleLogViewModel(useCase: battleLogUseCase)
    }
    
    //MARK: - TrophyGraphView
    private lazy var brawlerTrophyDataSource: BrawlerTrophyDataSource = {
        return MockBrawlerTrophyDataSourceImpl()
    }()
    
    private lazy var brawlerTrophyRepository: BrawlerTrophyRepository = {
        return BrawlerTrophyRepositoryImpl(dataSource: brawlerTrophyDataSource)
    }()
    
    private lazy var brawlerTrophyUseCase: BrawlerTrophyUseCase = {
        return BrawlerTrophyUseCaseImpl(repository: brawlerTrophyRepository)
    }()
    
    func makeBrawlerTrophyViewModel() -> BrawlerTrophyViewModel {
        return BrawlerTrophyViewModel(useCase: brawlerTrophyUseCase)
    }
    
    
    
}
