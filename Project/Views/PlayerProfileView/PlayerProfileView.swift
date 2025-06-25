//
//  PlayerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI



protocol PlayerProfileDataSource {
    func getUserProfile() -> UserTrophyModel
    func getBrawlersTrophy() -> [BrawlerTrophyModel]
}

class MockPlayerProfileDataSourceImpl: PlayerProfileDataSource {
    func getUserProfile() -> UserTrophyModel {
        return UserTrophyModel(
           nickName: "상진",
           club: "팀",
           rank: "diamond",
           total: 9200,
           max: 10000
        )
    }
    
    func getBrawlersTrophy() -> [BrawlerTrophyModel] {
        return [
            
        ]
    }
    
}


protocol PlayerProfileRepository {
    func getUserProfile() -> UserTrophyModel
}

class PlayerProfileRepositoryImpl: PlayerProfileRepository {
    let dataSource: PlayerProfileDataSource
    
    init(dataSource: PlayerProfileDataSource) {
        self.dataSource = dataSource
    }
    
    func getUserProfile() -> UserTrophyModel {
        return dataSource.getUserProfile()
    }
}


protocol PlayerProfileUseCase {
    func getUserProfile() -> UserTrophyModel
}

class PlayerProfileUseCaseImpl: PlayerProfileUseCase {
    
    private let repository: PlayerProfileRepository
    
    init(repository: PlayerProfileRepository) {
        self.repository = repository
    }
    
    func getUserProfile() -> UserTrophyModel {
        return repository.getUserProfile()
    }
    
    
}


class PlayerProfileViewModel: ObservableObject {
    private var useCase: PlayerProfileUseCase
    
    init(useCase: PlayerProfileUseCase) {
        self.useCase = useCase
    }
    
    func getUserProfile() -> UserTrophyModel {
        return useCase.getUserProfile()
    }
}


//유저 정보 카드 뷰
struct PlayerProfileView: View {
    
    private let vm: PlayerProfileViewModel
    
    init(vm: PlayerProfileViewModel) {
        self.vm = vm
    }
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.backgroundColor // 배경 뷰 (예: 색상)
                    .ignoresSafeArea() // 화면 전체로 확장
                
                ScrollView {
                    NavigationLink(destination: BattleLogView()) {
                        UserView(user: vm.getUserProfile())
                    }
                    
                    NavigationLink(destination: TrophyGraphView()) {
                        BrawlerTrophyView(
                            brawlerTrophyModel: BrawlerTrophyModel(
                                name: "kenji",
                                currentTrophy: 1000,
                                highestTrophy: 1000
                            )
                        )
                    }
                    
                }
            }
        }
    }
}


#Preview {
    PlayerProfileView(
        vm: PlayerProfileViewModel(
            useCase: PlayerProfileUseCaseImpl(
                repository: PlayerProfileRepositoryImpl(
                    dataSource: MockPlayerProfileDataSourceImpl()
                )
            )
        )
    )
}
